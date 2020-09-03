using System.Threading.Tasks;
using FakeItEasy;
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
            var user = new User
            {
                Id = 1374
            };

            A.CallTo(() => _fakeRandom.GenerateSecureString(A<int>._)).Returns("someRandomString");
            A.CallTo(() => _fakeRefreshTokenRepository.Insert(A<RefreshToken>._)).Returns(Task.FromResult(5));
            A.CallTo(() => _fakeJsonWebTokenService.CreateNewAccessToken(A<User>._)).Returns("access-token");

            var authToken = await _sut.CreateNewRefreshToken(user, new ConnectionInfo{Ip = "192.168.1.0"});

            Assert.Equal(OAuthToken.OAuthTokenType.Bearer, authToken.Type);
            Assert.Equal("access-token", authToken.AccessToken);
            Assert.Equal("someRandomString", authToken.RefreshToken);
            // Assert.Equal("refresh-token", authToken.Expires);

            A.CallTo(() => _fakeRefreshTokenRepository.Insert(A<RefreshToken>.That.Matches(token =>
                token.UserId == 1374 &&
                token.Token  == "someRandomString" &&
                token.LastUsedFromIp == "192.168.1.0"
            ))).MustHaveHappenedOnceExactly();
        }
    }
}