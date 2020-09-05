using System;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.Auth.V1;
using Padel.Proto.User.V1;
using Padel.Runner.Test.IntegrationTests.Helpers;
using Xunit;

namespace Padel.Runner.Test.IntegrationTests
{
    public class AuthServiceIntegrationTest : IClassFixture<CustomWebApplicationFactory<Startup>>
    {
        private readonly AuthService.AuthServiceClient _authServiceClient;
        private readonly UserService.UserServiceClient _userServiceClient;

        public AuthServiceIntegrationTest(CustomWebApplicationFactory<Startup> factory)
        {
            var channel = factory.CreateGrpcChannel();
            _authServiceClient = new AuthService.AuthServiceClient(channel);
            _userServiceClient = new UserService.UserServiceClient(channel);
        }

        [Fact]
        public async Task LoginsAfterSigningUpSuccessful()
        {
            static Metadata CreateAuthMetadata(OAuthToken oAuthToken)
            {
                return new Metadata {{"Authorization", $"Bearer {oAuthToken.AccessToken}"}};
            }

            var expectedTokenLength = TimeSpan.FromMinutes(30);
            var payload = new RegisterRequest
            {
                User = new NewUser
                {
                    Username = "login1",
                    Email = "login@padpal.io",
                    Password = "loggin1_password",
                    FirstName = "log",
                    LastName = "in",
                    DateOfBirth = new NewUser.Types.Date
                    {
                        Year = 10,
                        Month = 10,
                        Day = 10
                    }
                }
            };

            await _authServiceClient.RegisterAsync(payload);
            var loginResponse = await _authServiceClient.LoginAsync(new LoginRequest {Email = payload.User.Email, Password = payload.User.Password});

            var timeRange = DateTimeOffset.FromUnixTimeSeconds(loginResponse.Token.Expires) - DateTimeOffset.UtcNow - expectedTokenLength;
            Assert.True(timeRange < TimeSpan.FromSeconds(10));

            var meRes = await _userServiceClient.MeAsync(new MeRequest { }, CreateAuthMetadata(loginResponse.Token));
            Assert.Equal("login1", meRes.Me.Username);
            Assert.Equal("login@padpal.io", meRes.Me.Email);
            Assert.Equal("log", meRes.Me.FirstName);
            Assert.Equal("in", meRes.Me.LastName);

            // The JWT genreator will generate the same token twice sine there are no time between call
            await Task.Delay(1000);

            var newAccessTokenRes = await _authServiceClient.GetNewAccessTokenAsync(new GetNewAccessTokenRequest
                {RefreshToken = loginResponse.Token.RefreshToken}, CreateAuthMetadata(loginResponse.Token));
            Assert.NotEqual(newAccessTokenRes.Token.AccessToken, loginResponse.Token.AccessToken);
            Assert.Equal(newAccessTokenRes.Token.RefreshToken, loginResponse.Token.RefreshToken);

            var meResWithNewAccessToken = await _userServiceClient.MeAsync(new MeRequest { }, CreateAuthMetadata(newAccessTokenRes.Token));
            Assert.Equal("login1", meResWithNewAccessToken.Me.Username);
            Assert.Equal("login@padpal.io", meResWithNewAccessToken.Me.Email);
            Assert.Equal("log", meResWithNewAccessToken.Me.FirstName);
            Assert.Equal("in", meResWithNewAccessToken.Me.LastName);
        }

        [Fact]
        public async Task LoginsFailsWithBadCredentialsAfterSigningUpSuccessful()
        {
            var payload = new RegisterRequest
            {
                User = new NewUser
                {
                    Username = "login2",
                    Email = "login2",
                    Password = "loggin1_password",
                    FirstName = "log",
                    LastName = "in",
                    DateOfBirth = new NewUser.Types.Date
                    {
                        Year = 10,
                        Month = 10,
                        Day = 10
                    }
                }
            };

            await _authServiceClient.RegisterAsync(payload);

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.LoginAsync(new LoginRequest
            {
                Email = payload.User.Email,
                Password = "some other password"
            }));
        }

        [Fact]
        public async Task LoginsFailsWithBadCredentials()
        {
            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.LoginAsync(new LoginRequest
            {
                Email = "email_does_not_exists",
                Password = "some other password"
            }));
        }

        [Fact]
        public async Task ThrowsErrorWhenUsernameIsTaken()
        {
            var payload = new RegisterRequest
            {
                User = new NewUser
                {
                    Username = "username1",
                    Email = "username1",
                    Password = "password",
                    FirstName = "firstName",
                    LastName = "lastName",
                    DateOfBirth = new NewUser.Types.Date
                    {
                        Year = 10,
                        Month = 10,
                        Day = 10
                    }
                }
            };

            await _authServiceClient.RegisterAsync(payload);

            payload.User.Email = "someOtherEmail";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.RegisterAsync(payload));
            Assert.Equal("username-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }

        [Fact]
        public async Task ThrowsErrorWhenEmailIsTaken()
        {
            var payload = new RegisterRequest
            {
                User = new NewUser
                {
                    Username = "username2",
                    Email = "username2",
                    Password = "password",
                    FirstName = "firstName",
                    LastName = "lastName",
                    DateOfBirth = new NewUser.Types.Date
                    {
                        Year = 10,
                        Month = 10,
                        Day = 10
                    }
                }
            };

            await _authServiceClient.RegisterAsync(payload);

            payload.User.Username = "someNewUsername";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _authServiceClient.RegisterAsync(payload));
            Assert.Equal("email-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }
    }
}