using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;

namespace Padel.Login.Repositories.User
{
    public class UserRepository : RepositoryBase<User>, IUserRepository
    {
        public UserRepository(IDatabaseConnectionFactory connectionFactory) : base(connectionFactory)
        {
        }

        public async Task<User> FindByUsername(string username)
        {
            var dictionary = new Dictionary<string, object>
            {
                {"@Username", username}
            };

            using var conn = await ConnectionFactory.GetNewOpenConnection();
            return await conn.QuerySingleOrDefaultAsync<User>("SELECT * from [User] where Username = @Username", dictionary);
        }

        public async Task<User> FindByEmail(string email)
        {
            var dictionary = new Dictionary<string, object>
            {
                {"@Email", email}
            };

            using var conn = await ConnectionFactory.GetNewOpenConnection();
            return await conn.QuerySingleOrDefaultAsync<User>("SELECT * from [User] where Email = @Email", dictionary);
        }
    }
}