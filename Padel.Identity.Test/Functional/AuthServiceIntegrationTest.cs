using System;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Identity.Runner.Test.Functional.Helpers;
using Padel.Proto.Auth.V1;
using Padel.Proto.User.V1;
using Padel.Test.Core;
using Xunit;

namespace Padel.Identity.Runner.Test.Functional
{
    public abstract class GrpcIntegrationTestBase
    {
        private readonly AuthService.AuthServiceClient _authServiceClient;

        protected GrpcIntegrationTestBase(SqlWebApplicationFactory<Startup> factory)
        {
            var channel = factory.CreateGrpcChannel();
            _authServiceClient = new AuthService.AuthServiceClient(channel);
        }

        protected async Task<SignInResponse> RegisterAndSignInUser(UserGeneratedData user)
        {
            await _authServiceClient.RegisterAsync(new RegisterRequest {User = CreateNewUser(user)});

            return await _authServiceClient.SignInAsync(CreateSignInRequest(user));
        }

        protected static Metadata CreateAuthMetadata(OAuthToken oAuthToken)
        {
            return new Metadata {{"Authorization", $"Bearer {oAuthToken.AccessToken}"}};
        }

        protected static SignInRequest CreateSignInRequest(UserGeneratedData randomUser)
        {
            return new SignInRequest
            {
                Email = randomUser.Email,
                Password = randomUser.Password,
                FirebaseToken = randomUser.FirebaseToken
            };
        }

        protected static NewUser CreateNewUser(UserGeneratedData user)
        {
            return new NewUser
            {
                Username = user.Username,
                Email = user.Email,
                Password = user.Password,
                FirstName = user.FirstName,
                LastName = user.LastName,
                DateOfBirth = new NewUser.Types.Date {Year = user.DateOfBirth.Year, Month = user.DateOfBirth.Month, Day = user.DateOfBirth.Day}
            };
        }
    }

    public class AuthServiceIntegrationTest : GrpcIntegrationTestBase, IClassFixture<SqlWebApplicationFactory<Startup>>
    {
        private readonly AuthService.AuthServiceClient _authServiceClient;
        private readonly UserService.UserServiceClient _userServiceClient;
        private readonly UserGeneratedData             _randomUser;

        public AuthServiceIntegrationTest(SqlWebApplicationFactory<Startup> factory) : base(factory)
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
            var payload = new RegisterRequest {User = CreateNewUser(_randomUser)};

            await _authServiceClient.RegisterAsync(payload);
            var signInResponse = await _authServiceClient.SignInAsync(CreateSignInRequest(_randomUser));

            var timeRange = DateTimeOffset.FromUnixTimeSeconds(signInResponse.Token.Expires) - DateTimeOffset.UtcNow - expectedTokenLength;
            Assert.True(timeRange < TimeSpan.FromSeconds(10));

            var meRes = await _userServiceClient.MeAsync(new MeRequest { }, CreateAuthMetadata(signInResponse.Token));
            Assert.Equal(_randomUser.Username, meRes.Me.Username);
            Assert.Equal(_randomUser.Email, meRes.Me.Email);
            Assert.Equal(_randomUser.FirstName, meRes.Me.FirstName);
            Assert.Equal(_randomUser.LastName, meRes.Me.LastName);

            // The JWT genreator will generate the same token twice sine there are no time between call
            await Task.Delay(1000);

            var newAccessTokenRes = await _authServiceClient.GetNewAccessTokenAsync(new GetNewAccessTokenRequest
                {RefreshToken = signInResponse.Token.RefreshToken}, CreateAuthMetadata(signInResponse.Token));
            Assert.NotEqual(newAccessTokenRes.Token.AccessToken, signInResponse.Token.AccessToken);
            Assert.Equal(newAccessTokenRes.Token.RefreshToken, signInResponse.Token.RefreshToken);

            var meResWithNewAccessToken = await _userServiceClient.MeAsync(new MeRequest { }, CreateAuthMetadata(newAccessTokenRes.Token));
            Assert.Equal(_randomUser.Username, meResWithNewAccessToken.Me.Username);
            Assert.Equal(_randomUser.Email, meResWithNewAccessToken.Me.Email);
            Assert.Equal(_randomUser.FirstName, meResWithNewAccessToken.Me.FirstName);
            Assert.Equal(_randomUser.LastName, meResWithNewAccessToken.Me.LastName);
        }

        [Fact]
        public async Task SignInFailsWithBadCredentialsAfterRegisterSuccessful()
        {
            var payload = new RegisterRequest {User = CreateNewUser(_randomUser)};

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
            var payload = new RegisterRequest {User = CreateNewUser(_randomUser)};

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
            var payload = new RegisterRequest {User = CreateNewUser(_randomUser)};

            await _authServiceClient.RegisterAsync(payload);

            payload.User.Email = "someOtherEmail";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.RegisterAsync(payload));
            Assert.Equal("username-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }

        [Fact]
        public async Task ThrowsErrorWhenEmailIsTaken()
        {
            var payload = new RegisterRequest {User = CreateNewUser(_randomUser)};

            await _authServiceClient.RegisterAsync(payload);

            payload.User.Username = "someNewUsername";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.RegisterAsync(payload));
            Assert.Equal("email-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }
    }
}