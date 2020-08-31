using System.Threading.Tasks;
using Padel.Proto.User.V1;

namespace Padel.Login.Services
{
    public interface IUserService
    {
        Task RegisterNewUser(User user);
    }
}