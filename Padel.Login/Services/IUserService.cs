using System.Threading.Tasks;
using Padel.Proto.Auth.V1;
using OAuthToken = Padel.Login.Services.JsonWebToken.OAuthToken;

namespace Padel.Login.Services
{
    public interface IAuthService
    {
        Task RegisterNewUser(NewUser user);
        Task<OAuthToken> Login(LoginRequest request, ConnectionInfo info);
    }
}