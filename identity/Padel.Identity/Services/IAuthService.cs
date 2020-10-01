using System.Threading.Tasks;
using Padel.Identity.Models;
using Padel.Identity.Services.JsonWebToken;

namespace Padel.Identity.Services
{
    public interface IAuthService
    {
        Task RegisterNewUser(NewUser user);
        Task<OAuthToken> SignIn(SignInRequest request, ConnectionInfo info);
        Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info);
    }
}