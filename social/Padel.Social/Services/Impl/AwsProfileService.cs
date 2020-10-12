using System;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using Amazon.S3;
using Amazon.S3.Model;
using Microsoft.Extensions.Configuration;
using Padel.Social.Services.Interface;

namespace Padel.Social.Services.Impl
{
    public class AwsProfilePictureService : IProfilePictureService
    {
        private readonly IAmazonS3 _s3;
        private          string    _bucketName;

        public AwsProfilePictureService(IAmazonS3 s3, IConfiguration configuration)
        {
            _s3 = s3;
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
            var res = await _s3.PutObjectAsync(new PutObjectRequest
            {
                Key = userId.ToString(),
                BucketName = _bucketName,
                InputStream = stream,
                ContentType = "image/jpg",
                CannedACL = S3CannedACL.PublicRead,
            });

            var id = $"https://s3.{_s3.Config.RegionEndpoint.SystemName}.amazonaws.com/{_bucketName}/{userId}";
            if (res.HttpStatusCode != HttpStatusCode.OK)
            {
                throw new Exception($"update for id: {id} returned none 200 stauts code, actual: ({res.HttpStatusCode})");
            }

            return id;
        }
    }
}