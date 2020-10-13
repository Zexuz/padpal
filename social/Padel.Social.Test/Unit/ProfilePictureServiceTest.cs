using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using FakeItEasy;
using Microsoft.Extensions.Configuration;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class ProfilePictureServiceTest
    {
        private readonly AwsProfilePictureService _sut;
        private readonly IAmazonS3                _fakeAmazonS3;
        private readonly IProfileRepository       _fakeProfileRepository;

        public ProfilePictureServiceTest()
        {
            _fakeAmazonS3 = A.Fake<IAmazonS3>();
            var fakeConfig = A.Fake<IConfiguration>();
            _fakeProfileRepository = A.Fake<IProfileRepository>();

            A.CallTo(() => fakeConfig["AWS:ProfileBucket"]).Returns("mkdir.se.padpals.profile-pictures");

            _sut = TestHelper.ActivateWithFakes<AwsProfilePictureService>(_fakeAmazonS3, fakeConfig, _fakeProfileRepository);
        }


        [Fact]
        public async Task Should_set_public_access_on_image()
        {
            var currentUnixTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString().Substring(0, 8);
            var userId = 1337;
            A.CallTo(() => _fakeAmazonS3.Config).Returns(new AmazonS3Config {RegionEndpoint = RegionEndpoint.EUNorth1});
            A.CallTo(() => _fakeAmazonS3.PutObjectAsync(A<PutObjectRequest>._, default))
                .Returns(new PutObjectResponse {HttpStatusCode = HttpStatusCode.OK});

            var stream = new MemoryStream();

            var result = await _sut.Update(userId, stream);

            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>.That.Matches(profile => profile.PictureUrl == result)))
                .MustHaveHappened();
            Assert.Contains($"https://s3.eu-north-1.amazonaws.com/mkdir.se.padpals.profile-pictures/1337-{currentUnixTimestamp}", result);
            A.CallTo(() => _fakeAmazonS3.PutObjectAsync(A<PutObjectRequest>.That.Matches(request =>
                request.Key.Contains($"1337-{currentUnixTimestamp}")      &&
                request.BucketName == "mkdir.se.padpals.profile-pictures" &&
                request.CannedACL  == S3CannedACL.PublicRead
            ), default)).MustHaveHappened();
        }

        [Fact]
        public async Task Should_remove_all_other_keys_belonging_to_user()
        {
            var userId = 1337;
            A.CallTo(() => _fakeAmazonS3.Config).Returns(new AmazonS3Config {RegionEndpoint = RegionEndpoint.EUNorth1});
            A.CallTo(() => _fakeAmazonS3.PutObjectAsync(A<PutObjectRequest>._, default))
                .Returns(new PutObjectResponse {HttpStatusCode = HttpStatusCode.OK});

            A.CallTo(() => _fakeAmazonS3.GetAllObjectKeysAsync(A<string>._, A<string>._, A<IDictionary<string, object>>._))
                .Returns(new List<string>
                {
                    "1337-1",
                    "1337-101454",
                    "1337-9849",
                    "1337-askjdasjkd",
                });

            var stream = new MemoryStream();

            await _sut.Update(userId, stream);

            A.CallTo(() => _fakeAmazonS3.DeleteObjectsAsync(A<DeleteObjectsRequest>.That.Matches(request =>
                    request.BucketName    == "mkdir.se.padpals.profile-pictures" &&
                    request.Objects.Count == 4
                ), default)
            ).MustHaveHappened();

            A.CallTo(() => _fakeAmazonS3.GetAllObjectKeysAsync("mkdir.se.padpals.profile-pictures", "1337-", A<IDictionary<string, object>>._)).MustHaveHappened()
                .Then(A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>._)).MustHaveHappened());
        }
    }
}