using System.Threading.Tasks;
using Padel.Login.Models;
using Padel.Login.Services.JsonWebToken;

namespace Padel.Login.Services
{
    public interface IAuthService
    {
        Task RegisterNewUser(NewUser user);
        Task<OAuthToken> Login(LoginRequest request, ConnectionInfo info);
        Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info);
    }
}