using System.Threading.Tasks;
using Padel.Login.Repositories.User;
using Padel.Login.Services.JsonWebToken;

namespace Padel.Login.Services
{
    public interface IOAuthTokenService
    {
        Task InvalidateRefreshToken(User user, string refreshToken);
        Task<OAuthToken> CreateNewRefreshToken(User user, ConnectionInfo connectionInfo);
        Task<OAuthToken> CreateNewAccessToken(User user, string refreshToken);
    }
}