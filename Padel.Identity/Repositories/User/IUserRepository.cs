using System.Threading.Tasks;

namespace Padel.Identity.Repositories.User
{
    public interface IUserRepository : IRepositoryBase<User>
    {
        Task<User>? FindByUsername(string username);
        Task<User>? FindByEmail(string email);
    }
}