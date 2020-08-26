using System.Threading.Tasks;

namespace Padel.Login.Test
{
    public interface IUserRepository : IRepositoryBase<User>
    {
        Task<User>? FindByUsername(string username);
        Task<User>? FindByEmail(string email);
    }
}