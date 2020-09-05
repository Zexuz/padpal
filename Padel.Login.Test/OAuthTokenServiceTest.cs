using System;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.RefreshToken;
using Padel.Login.Repositories.User;
using Padel.Login.Services;
using Padel.Login.Services.JsonWebToken;
using Xunit;

namespace Padel.Login.Test
{
    public class OAuthTokenServiceTest
    {
        private readonly OAuthTokenService       _sut;
        private readonly IJsonWebTokenService    _fakeJsonWebTokenService;
        private readonly IRefreshTokenRepository _fakeRefreshTokenRepository;
        private readonly IRandom                 _fakeRandom;


        public OAuthTokenServiceTest()
        {
            _fakeJsonWebTokenService = A.Fake<IJsonWebTokenService>();
            _fakeRefreshTokenRepository = A.Fake<IRefreshTokenRepository>();
            _fakeRandom = A.Fake<IRandom>();

            _sut = new OAuthTokenService(_fakeJsonWebTokenService, _fakeRefreshTokenRepository, _fakeRandom);
        }

        [Fact]
        public async Task Should_return_OAuthToken()
        {
            A.CallTo(() => _fakeRandom.GenerateSecureString(A<int>._)).Returns("someRandomString");
            A.CallTo(() => _fakeRefreshTokenRepository.Insert(A<RefreshToken>._)).Returns(Task.FromResult(5));
            A.CallTo(() => _fakeJsonWebTokenService.CreateNewAccessToken(A<int>._))
                .Returns(("access-token", DateTimeOffset.Parse("2020-09-03 20:07")));

            var authToken = await _sut.CreateNewRefreshToken(1374, new ConnectionInfo {Ip = "192.168.1.0"});

            Assert.Equal(OAuthToken.OAuthTokenType.Bearer, authToken.Type);
            Assert.Equal("access-token", authToken.AccessToken);
            Assert.Equal("someRandomString", authToken.RefreshToken);
            Assert.Equal(DateTimeOffset.Parse("2020-09-03 20:07"), authToken.Expires);

            A.CallTo(() => _fakeRefreshTokenRepository.Insert(A<RefreshToken>.That.Matches(token =>
                token.UserId         == 1374               &&
                token.Token          == "someRandomString" &&
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
            A.CallTo(() => _fakeRefreshTokenRepository.FindToken(refreshToken)).Returns(Task.FromResult<RefreshToken?>(new RefreshToken
            {
                UserId = userId,
                IsDisabled = false,
                Token = refreshToken,
            }));

            var res = await _sut.RefreshAccessToken(refreshToken, new ConnectionInfo {Ip = "192.168.0.1"});

            Assert.Equal("someNewAccessToken", res.AccessToken);
            Assert.Equal(refreshToken, res.RefreshToken);

            A.CallTo(() => _fakeRefreshTokenRepository.UpdateAsync(A<RefreshToken>.That.Matches(token =>
                    token.UserId                           == userId        &&
                    token.Token                            == refreshToken  &&
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

            A.CallTo(() => _fakeRefreshTokenRepository.FindToken(refreshToken)).Returns(Task.FromResult<RefreshToken?>(null!));

            var ex = await Assert.ThrowsAsync<RefreshTokenDoesNotExistException>(() => _sut.RefreshAccessToken(refreshToken, connectionInfo));

            Assert.Equal(refreshToken, ex.RefreshToken);
            Assert.Equal("someIp", ex.Ip);
        }

        [Fact]
        public async Task Should_throw_exception_if_refreshToken_is_revoked()
        {
            var refreshToken = "someNoneExistingToken";
            var connectionInfo = new ConnectionInfo {Ip = "someIp"};

            A.CallTo(() => _fakeRefreshTokenRepository.FindToken(refreshToken)).Returns(Task.FromResult<RefreshToken?>(new RefreshToken
            {
                Id = 1337,
                IsDisabled = true,
                Token = refreshToken,
            }));

            var ex = await Assert.ThrowsAsync<RefreshTokenIsRevokedException>(() => _sut.RefreshAccessToken(refreshToken, connectionInfo));

            Assert.Equal(1337, ex.TokenId);
            Assert.Equal("someIp", ex.Ip);
        }
    }
}