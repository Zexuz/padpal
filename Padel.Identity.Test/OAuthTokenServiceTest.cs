using System;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Identity.Exceptions;
using Padel.Identity.Repositories.Device;
using Padel.Identity.Services;
using Padel.Identity.Services.JsonWebToken;
using Xunit;

namespace Padel.Identity.Test
{
    public class OAuthTokenServiceTest
    {
        private readonly OAuthTokenService    _sut;
        private readonly IJsonWebTokenService _fakeJsonWebTokenService;
        private readonly IDeviceRepository    _fakeDeviceRepository;
        private readonly IRandom              _fakeRandom;


        public OAuthTokenServiceTest()
        {
            _fakeJsonWebTokenService = A.Fake<IJsonWebTokenService>();
            _fakeDeviceRepository = A.Fake<IDeviceRepository>();
            _fakeRandom = A.Fake<IRandom>();

            _sut = new OAuthTokenService(_fakeJsonWebTokenService, _fakeDeviceRepository, _fakeRandom);
        }

        [Fact]
        public async Task Should_return_OAuthToken()
        {
            A.CallTo(() => _fakeRandom.GenerateSecureString(A<int>._)).Returns("someRandomString");
            A.CallTo(() => _fakeDeviceRepository.Insert(A<Device>._)).Returns(Task.FromResult(5));
            A.CallTo(() => _fakeJsonWebTokenService.CreateNewAccessToken(A<int>._))
                .Returns(("access-token", DateTimeOffset.Parse("2020-09-03 20:07")));

            var authToken = await _sut.CreateNewRefreshToken(1374, "firebaseToken", new ConnectionInfo {Ip = "192.168.1.0"});

            Assert.Equal(OAuthToken.OAuthTokenType.Bearer, authToken.Type);
            Assert.Equal("access-token", authToken.AccessToken);
            Assert.Equal("someRandomString", authToken.RefreshToken);
            Assert.Equal(DateTimeOffset.Parse("2020-09-03 20:07"), authToken.Expires);

            A.CallTo(() => _fakeDeviceRepository.Insert(A<Device>.That.Matches(token =>
                token.UserId         == 1374               &&
                token.RefreshToken   == "someRandomString" &&
                token.LastUsedFromIp == "192.168.1.0"
            ))).MustHaveHappenedOnceExactly();
        }

        [Theory]
        [InlineData(1)]
        [InlineData(99)]
        public async Task Should_refresh_accessToken_with_valid_refreshToken(int userId)
        {
            const string refreshToken = "someToken";

            A.CallTo(() => _fakeJsonWebTokenService.CreateNewAccessToken(userId))
                .Returns(Task.FromResult(("someNewAccessToken", DateTimeOffset.UtcNow)));
            A.CallTo(() => _fakeDeviceRepository.FindByRefreshToken(refreshToken)).Returns(Task.FromResult<Device?>(new Device
            {
                UserId = userId,
                IsDisabled = false,
                RefreshToken = refreshToken
            }));

            var res = await _sut.RefreshAccessToken(refreshToken, new ConnectionInfo {Ip = "192.168.0.1"});

            Assert.Equal("someNewAccessToken", res.AccessToken);
            Assert.Equal(refreshToken, res.RefreshToken);

            A.CallTo(() => _fakeDeviceRepository.UpdateAsync(A<Device>.That.Matches(token =>
                    token.UserId                           == userId        &&
                    token.RefreshToken                     == refreshToken  &&
                    token.LastUsedFromIp                   == "192.168.0.1" &&
                    token.LastUsed - DateTimeOffset.UtcNow < TimeSpan.FromSeconds(1)
                )
            )).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_throw_exception_if_invalid_refreshToken()
        {
            var refreshToken = "someNoneExistingToken";
            var connectionInfo = new ConnectionInfo {Ip = "someIp"};

            A.CallTo(() => _fakeDeviceRepository.FindByRefreshToken(refreshToken)).Returns(Task.FromResult<Device?>(null!));

            var ex = await Assert.ThrowsAsync<RefreshTokenDoesNotExistException>(() => _sut.RefreshAccessToken(refreshToken, connectionInfo));

            Assert.Equal(refreshToken, ex.RefreshToken);
            Assert.Equal("someIp", ex.Ip);
        }

        [Fact]
        public async Task Should_throw_exception_if_refreshToken_is_revoked()
        {
            var refreshToken = "someNoneExistingToken";
            var connectionInfo = new ConnectionInfo {Ip = "someIp"};

            A.CallTo(() => _fakeDeviceRepository.FindByRefreshToken(refreshToken)).Returns(Task.FromResult<Device?>(new Device
            {
                Id = 1337,
                IsDisabled = true,
                RefreshToken = refreshToken
            }));

            var ex = await Assert.ThrowsAsync<RefreshTokenIsRevokedException>(() => _sut.RefreshAccessToken(refreshToken, connectionInfo));

            Assert.Equal(1337, ex.TokenId);
            Assert.Equal("someIp", ex.Ip);
        }
    }
}