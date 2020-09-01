using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.User.V1;
using Padel.Runner;
using Xunit;

namespace Padel.Login.Test
{
    public class UserSignsUpSuccessfullyIntegrationTest : IClassFixture<CustomWebApplicationFactory<Startup>>
    {
        private readonly CustomWebApplicationFactory<Startup> _factory;

        public UserSignsUpSuccessfullyIntegrationTest(CustomWebApplicationFactory<Startup> factory)
        {
            _factory = factory;
        }

        [Fact]
        public async Task SignsUpSuccess()
        {
            var userServiceClient = new UserService.UserServiceClient(_factory.CreateGrpcChannel());

            var payload = new RegisterRequest
            {
                User = new User
                {
                    Username = "robin123",
                    Email = "robin123",
                    Password = "Hello4",
                    FirstName = "Hello4",
                    LastName = "Hello4",
                    DateOfBirth = new User.Types.Date
                    {
                        Year = 10,
                        Month = 10,
                        Day = 10
                    }
                }
            };

            await userServiceClient.RegisterAsync(payload);
        }
        
        [Fact]
        public async Task ThrowsErrorWhenUsernameIsTaken()
        {
            var userServiceClient = new UserService.UserServiceClient(_factory.CreateGrpcChannel());

            var payload = new RegisterRequest
            {
                User = new User
                {
                    Username = "username1",
                    Email = "username1",
                    Password = "password",
                    FirstName = "firstName",
                    LastName = "lastName",
                    DateOfBirth = new User.Types.Date
                    {
                        Year = 10,
                        Month = 10,
                        Day = 10
                    }
                }
            };

            await userServiceClient.RegisterAsync(payload);

            payload.User.Email = "someOtherEmail";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await userServiceClient.RegisterAsync(payload));
            Assert.Equal("username-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }
        
        [Fact]
        public async Task ThrowsErrorWhenEmailIsTaken()
        {
            var userServiceClient = new UserService.UserServiceClient(_factory.CreateGrpcChannel());

            var payload = new RegisterRequest
            {
                User = new User
                {
                    Username = "username2",
                    Email = "username2",
                    Password = "password",
                    FirstName = "firstName",
                    LastName = "lastName",
                    DateOfBirth = new User.Types.Date
                    {
                        Year = 10,
                        Month = 10,
                        Day = 10
                    }
                }
            };

            await userServiceClient.RegisterAsync(payload);

            payload.User.Username = "someNewUsername";

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await userServiceClient.RegisterAsync(payload));
            Assert.Equal("email-already-taken", ex.Trailers.GetValue("x-custom-error"));
        }
    }
}