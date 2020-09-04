using System;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Login.Test.IntegrationTests.Helpers;
using Padel.Proto.Auth.V1;
using Padel.Runner;
using Xunit;

namespace Padel.Login.Test.IntegrationTests
{
    public class AuthServiceIntegrationTest : IClassFixture<CustomWebApplicationFactory<Startup>>
    {
        private readonly AuthService.AuthServiceClient _authServiceClient;

        public AuthServiceIntegrationTest(CustomWebApplicationFactory<Startup> factory)
        {
            _authServiceClient = new AuthService.AuthServiceClient(factory.CreateGrpcChannel());
        }

        [Fact]
        public async Task LoginsAfterSigningUpSuccessful()
        {
            var expectedTokenLength = TimeSpan.FromMinutes(30);
            var payload = new RegisterRequest
            {
                User = new NewUser
                {
                    Username = "login1",
                    Email = "login1",
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

            var loginPayload = new LoginRequest
            {
                Email = payload.User.Email,
                Password = payload.User.Password
            };

            await _authServiceClient.RegisterAsync(payload);
            var res = await _authServiceClient.LoginAsync(loginPayload);

            var timeRange = DateTimeOffset.FromUnixTimeSeconds(res.Token.Expires) - DateTimeOffset.UtcNow - expectedTokenLength;

            // TODO Verify that these tokens work. One by getting a new access token, and another by doing something, like getting the current user info?
            Assert.True(timeRange                     < TimeSpan.FromSeconds(10));
            Assert.True(res.Token.RefreshToken.Length > 60);
            Assert.True(res.Token.AccessToken.Length  > 60);
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