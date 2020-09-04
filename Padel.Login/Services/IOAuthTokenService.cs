using System.Threading.Tasks;
using Padel.Login.Repositories.User;
using Padel.Login.Services.JsonWebToken;

namespace Padel.Login.Services
{
    public interface IOAuthTokenService
    {
        // TODO Replace User user -> int userId
        Task InvalidateRefreshToken(User user, string refreshToken);

        // TODO Replace User user -> int userId
        Task<OAuthToken> CreateNewRefreshToken(User user, ConnectionInfo connectionInfo);

        Task<OAuthToken> CreateNewAccessToken(int userId, string refreshToken);
    }
}