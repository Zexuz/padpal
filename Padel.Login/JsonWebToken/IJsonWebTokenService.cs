using System.Threading.Tasks;
using Padel.Login.Repositories.User;

namespace Padel.Login.JsonWebToken
{
    public interface IJsonWebTokenService
    {
        Task<string> CreateNewAccessToken(User user);
    }
}