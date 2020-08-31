using System.Threading.Tasks;
using Padel.Proto.User;

namespace Padel.Login.Services
{
    public interface IUserService
    {
        Task RegisterNewUser(User user);
    }
}