using System.Threading.Tasks;
using Padel.Identity.Services.JsonWebToken;

namespace Padel.Identity.Services
{
    public interface IOAuthTokenService
    {
        Task InvalidateRefreshToken(int userId, string refreshToken);

        Task<OAuthToken> CreateNewRefreshToken(int userId, ConnectionInfo connectionInfo);

        Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info);
    }
}