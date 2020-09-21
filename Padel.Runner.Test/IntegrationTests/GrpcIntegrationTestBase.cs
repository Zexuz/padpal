using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.Auth.V1;
using Padel.Runner.Test.IntegrationTests.Helpers;

namespace Padel.Runner.Test.IntegrationTests
{
    public abstract class GrpcIntegrationTestBase
    {
        private readonly AuthService.AuthServiceClient _authServiceClient;

        protected GrpcIntegrationTestBase(CustomWebApplicationFactory<Startup> factory)
        {
            var channel = factory.CreateGrpcChannel();
            _authServiceClient = new AuthService.AuthServiceClient(channel);
        }

        protected async Task<LoginResponse> RegisterAndLoginUser(UserGeneratedData user)
        {
            await _authServiceClient.RegisterAsync(new RegisterRequest {User = user.NewUser});

            return await _authServiceClient.LoginAsync(CreateLoginRequest(user));
        }

        protected static Metadata CreateAuthMetadata(OAuthToken oAuthToken)
        {
            return new Metadata {{"Authorization", $"Bearer {oAuthToken.AccessToken}"}};
        }

        protected static LoginRequest CreateLoginRequest(UserGeneratedData randomUser)
        {
            return new LoginRequest
            {
                Email = randomUser.Email,
                Password = randomUser.Password,
                FirebaseToken = randomUser.FirebaseToken
            };
        }
    }
}