using System.Threading.Tasks;
using Padel.Login.Repositories.User;
using Padel.Login.Services.JsonWebToken;

namespace Padel.Login.Services
{
    public interface IOAuthTokenService
    {
        Task InvalidateRefreshToken(int userId, string refreshToken);

        // TODO Replace User user -> int userId
        Task<OAuthToken> CreateNewRefreshToken(int userId, ConnectionInfo connectionInfo);

        Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info);
    }
}