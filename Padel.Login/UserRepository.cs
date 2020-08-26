using System.Threading.Tasks;

namespace Padel.Login.Test
{
    class UserRepository : RepositoryBase<User>, IUserRepository
    {
        public UserRepository(IDatabaseConnectionFactory connectionFactory) : base(connectionFactory)
        {
        }

        public Task<User>? FindByUsername(string username)
        {
            throw new System.NotImplementedException();
        }

        public Task<User>? FindByEmail(string email)
        {
            throw new System.NotImplementedException();
        }
    }
}