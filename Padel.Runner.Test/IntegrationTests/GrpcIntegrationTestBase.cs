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

        protected async Task<SignInResponse> RegisterAndSignInUser(UserGeneratedData user)
        {
            await _authServiceClient.RegisterAsync(new RegisterRequest {User = user.NewUser});

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
    }
}