using System.Threading.Tasks;
using Padel.Proto.User.V1;
using OAuthToken = Padel.Login.Services.JsonWebToken.OAuthToken;

namespace Padel.Login.Services
{
    public interface IUserService
    {
        Task RegisterNewUser(NewUser user);
        Task<OAuthToken> Login(LoginRequest request);
    }
}