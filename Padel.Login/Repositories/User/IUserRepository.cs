using System.Threading.Tasks;

namespace Padel.Login.Repositories.User
{
    public interface IUserRepository : IRepositoryBase<User>
    {
        Task<User>? FindByUsername(string username);
        Task<User>? FindByEmail(string email);
    }
}