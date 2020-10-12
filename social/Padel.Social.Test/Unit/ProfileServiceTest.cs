using System.IO;
using System.Net;
using System.Threading.Tasks;
using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using FakeItEasy;
using Microsoft.Extensions.Configuration;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class ProfilePictureServiceTest
    {
        private readonly AwsProfilePictureService _sut;
        private readonly IAmazonS3         _fakeAmazonS3;
        private          IConfiguration    _fakeConfig;

        public ProfilePictureServiceTest()
        {
            _fakeAmazonS3 = A.Fake<IAmazonS3>();
            _fakeConfig = A.Fake<IConfiguration>();

            A.CallTo(() => _fakeConfig["AWS:ProfileBucket"]).Returns("mkdir.se.padpals.profile-pictures");

            _sut = TestHelper.ActivateWithFakes<AwsProfilePictureService>(_fakeAmazonS3, _fakeConfig);
        }


        [Fact]
        public async Task Should_set_public_access_on_image()
        {
            var userId = 1337;
            A.CallTo(() => _fakeAmazonS3.Config).Returns(new AmazonS3Config {RegionEndpoint = RegionEndpoint.EUNorth1});
            A.CallTo(() => _fakeAmazonS3.PutObjectAsync(A<PutObjectRequest>._, default))
                .Returns(new PutObjectResponse {HttpStatusCode = HttpStatusCode.OK});

            var stream = new MemoryStream();

            var result = await _sut.Update(userId, stream);

            Assert.Equal("https://s3.eu-north-1.amazonaws.com/mkdir.se.padpals.profile-pictures/1337", result);
            A.CallTo(() => _fakeAmazonS3.PutObjectAsync(A<PutObjectRequest>.That.Matches(request =>
                request.Key        == "1337"                              &&
                request.BucketName == "mkdir.se.padpals.profile-pictures" &&
                request.CannedACL  == S3CannedACL.PublicRead
            ), default)).MustHaveHappened();
        }
    }
}