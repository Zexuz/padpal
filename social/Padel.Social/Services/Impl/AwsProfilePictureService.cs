using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Amazon.S3;
using Amazon.S3.Model;
using Microsoft.Extensions.Configuration;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;

namespace Padel.Social.Services.Impl
{
    public class AwsProfilePictureService : IProfilePictureService
    {
        private readonly IAmazonS3          _s3;
        private readonly IProfileRepository _profileRepository;
        private          string             _bucketName;

        public AwsProfilePictureService(IAmazonS3 s3, IProfileRepository profileRepository, IConfiguration configuration)
        {
            _s3 = s3;
            _profileRepository = profileRepository;
            _bucketName = configuration["AWS:ProfileBucket"];
        }

        public async Task VerifyBucketExists()
        {
            try
            {
                var response = await _s3.PutBucketAsync(new PutBucketRequest {BucketName = _bucketName});
                if (response.HttpStatusCode != HttpStatusCode.OK)
                {
                    throw new Exception("Could not create bucket!");
                }

                var aclResponse = await _s3.PutPublicAccessBlockAsync(
                    new PutPublicAccessBlockRequest
                    {
                        BucketName = _bucketName,
                        PublicAccessBlockConfiguration = new PublicAccessBlockConfiguration
                        {
                            BlockPublicAcls = false,
                            BlockPublicPolicy = false,
                            RestrictPublicBuckets = false,
                        }
                    }
                );
                if (aclResponse.HttpStatusCode != HttpStatusCode.OK)
                {
                    throw new Exception("Could not set correct access for bucket!");
                }
            }
            catch (Exception e)
            {
                if (e.Message.Contains("Your previous request to create the named bucket succeeded and you already own it."))
                {
                    return;
                }

                throw;
            }
        }

        public async Task<string> Update(int userId, MemoryStream stream)
        {
            var key = $"{userId}-{DateTimeOffset.UtcNow.ToUnixTimeSeconds()}";

            var keys = await _s3.GetAllObjectKeysAsync(_bucketName, $"{userId}-", new Dictionary<string, object>());

            var res = await _s3.PutObjectAsync(new PutObjectRequest
            {
                Key = key,
                BucketName = _bucketName,
                InputStream = stream,
                ContentType = "image/jpg",
                CannedACL = S3CannedACL.PublicRead,
            });

            var id = $"https://s3.{_s3.Config.RegionEndpoint.SystemName}.amazonaws.com/{_bucketName}/{key}";
            if (res.HttpStatusCode != HttpStatusCode.OK)
            {
                throw new Exception($"update for id: {id} returned none 200 stauts code, actual: ({res.HttpStatusCode})");
            }

            await _s3.DeleteObjectsAsync(new DeleteObjectsRequest
            {
                BucketName = _bucketName,
                Objects = keys.Select(s => new KeyVersion {Key = s}).ToList()
            });

            var profile = _profileRepository.FindByUserId(userId);
            profile.PictureUrl = id;
            await _profileRepository.ReplaceOneAsync(profile);

            return id;
        }
    }
}