#nullable enable
using System.Threading.Tasks;

namespace Padel.Login.Repositories.User
{
   public  class UserRepository : RepositoryBase<User>, IUserRepository
    {
        public UserRepository(IDatabaseConnectionFactory connectionFactory) : base(connectionFactory)
        {
        }

        public Task<User?> FindByUsername(string username)
        {
            return Task.FromResult<User>(null!)!;
        }

        public Task<User?> FindByEmail(string email)
        {
            return Task.FromResult<User>(null!)!;
        }
    }
}