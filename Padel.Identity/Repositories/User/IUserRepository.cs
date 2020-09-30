using System.Threading.Tasks;

namespace Padel.Identity.Repositories.User
{
    public interface IUserRepository : IRepositoryBase<User>
    {
        Task<User>? FindByEmail(string email);
    }
}