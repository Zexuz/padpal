using System.Threading.Tasks;
using Padel.Login.Services.JsonWebToken;

namespace Padel.Login.Services
{
    public interface IAuthService
    {
        Task RegisterNewUser(NewUser user);
        Task<OAuthToken> Login(LoginRequest request, ConnectionInfo info);
        Task<OAuthToken> RefreshAccessToken(int userId, string refreshToken, ConnectionInfo info);
    }
}