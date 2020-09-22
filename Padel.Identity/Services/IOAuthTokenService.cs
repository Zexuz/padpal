using System.Threading.Tasks;
using Padel.Identity.Services.JsonWebToken;

namespace Padel.Identity.Services
{
    public interface IOAuthTokenService
    {
        Task InvalidateRefreshToken(int userId, string refreshToken);

        // TODO Replace User user -> int userId
        Task<OAuthToken> CreateNewRefreshToken(int userId, string firebaseToken, ConnectionInfo connectionInfo);

        Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info);
    }
}