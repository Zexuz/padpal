using System;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.Auth.V1;
using Padel.Proto.User.V1;
using Padel.Runner.Test.IntegrationTests.Helpers;
using Xunit;

namespace Padel.Runner.Test.IntegrationTests
{
    public class AuthServiceIntegrationTest : GrpcIntegrationTestBase, IClassFixture<CustomWebApplicationFactory<Startup>>
    {
        private readonly AuthService.AuthServiceClient _authServiceClient;
        private readonly UserService.UserServiceClient _userServiceClient;
        private readonly UserGeneratedData             _randomUser;

        public AuthServiceIntegrationTest(CustomWebApplicationFactory<Startup> factory) : base(factory)
        {
            var channel = factory.CreateGrpcChannel();
            _authServiceClient = new AuthService.AuthServiceClient(channel);
            _userServiceClient = new UserService.UserServiceClient(channel);
            _randomUser = UserGeneratedData.Random();
        }

        [Fact]
        public async Task SignInAfterRegisterSuccessful()
        {
            var expectedTokenLength = TimeSpan.FromMinutes(30);
            var payload = new RegisterRequest {User = _randomUser.NewUser};

            await _authServiceClient.RegisterAsync(payload);
            var loginResponse = await _authServiceClient.SignInAsync(CreateSignInRequest(_randomUser));

            var timeRange = DateTimeOffset.FromUnixTimeSeconds(loginResponse.Token.Expires) - DateTimeOffset.UtcNow - expectedTokenLength;
            Assert.True(timeRange < TimeSpan.FromSeconds(10));

            var meRes = await _userServiceClient.MeAsync(new MeRequest { }, CreateAuthMetadata(loginResponse.Token));
            Assert.Equal(_randomUser.Username, meRes.Me.Username);
            Assert.Equal(_randomUser.Email, meRes.Me.Email);
            Assert.Equal(_randomUser.FirstName, meRes.Me.FirstName);
            Assert.Equal(_randomUser.LastName, meRes.Me.LastName);

            // The JWT genreator will generate the same token twice sine there are no time between call
            await Task.Delay(1000);

            var newAccessTokenRes = await _authServiceClient.GetNewAccessTokenAsync(new GetNewAccessTokenRequest
                {RefreshToken = loginResponse.Token.RefreshToken}, CreateAuthMetadata(loginResponse.Token));
            Assert.NotEqual(newAccessTokenRes.Token.AccessToken, loginResponse.Token.AccessToken);
            Assert.Equal(newAccessTokenRes.Token.RefreshToken, loginResponse.Token.RefreshToken);

            var meResWithNewAccessToken = await _userServiceClient.MeAsync(new MeRequest { }, CreateAuthMetadata(newAccessTokenRes.Token));
            Assert.Equal(_randomUser.Username, meResWithNewAccessToken.Me.Username);
            Assert.Equal(_randomUser.Email, meResWithNewAccessToken.Me.Email);
            Assert.Equal(_randomUser.FirstName, meResWithNewAccessToken.Me.FirstName);
            Assert.Equal(_randomUser.LastName, meResWithNewAccessToken.Me.LastName);
        }

        [Fact]
        public async Task SignInFailsWithBadCredentialsAfterRegisterSuccessful()
        {
            var payload = new RegisterRequest {User = _randomUser.NewUser};

            await _authServiceClient.RegisterAsync(payload);

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.SignInAsync(new SignInRequest
            {
                Email = payload.User.Email,
                Password = "some other password"
            }));
        }

        [Theory]
        [InlineData("")]
        public async Task SignInFailsWithBadFirebaseTokenAfterRegisterSuccessful(string firebaseToken)
        {
            var payload = new RegisterRequest {User = _randomUser.NewUser};

            await _authServiceClient.RegisterAsync(payload);

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.SignInAsync(new SignInRequest
            {
                Email = payload.User.Email,
                Password = payload.User.Password,
                FirebaseToken = firebaseToken,
            }));
        }

        [Fact]
        public async Task SignInFailsWithBadCredentials()
        {
            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.SignInAsync(new SignInRequest
            {
                Email = "email_does_not_exists",
                Password = "some other password"
            }));
        }

        [Fact]
        public async Task ThrowsErrorWhenUsernameIsTaken()
        {
            var payload = new RegisterRequest {User = _randomUser.NewUser};

            await _authServiceClient.RegisterAsync(payload);

            payload.User.Email = "someOtherEmail";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.RegisterAsync(payload));
            Assert.Equal("username-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }

        [Fact]
        public async Task ThrowsErrorWhenEmailIsTaken()
        {
            var payload = new RegisterRequest {User = _randomUser.NewUser};

            await _authServiceClient.RegisterAsync(payload);

            payload.User.Username = "someNewUsername";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.RegisterAsync(payload));
            Assert.Equal("email-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }
    }
}