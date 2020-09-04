using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;

namespace Padel.Login.Repositories.RefreshToken
{
    public class RefreshTokenRepository : RepositoryBase<RefreshToken>, IRefreshTokenRepository
    {
        public RefreshTokenRepository(IDatabaseConnectionFactory connectionFactory) : base(connectionFactory)
        {
        }

        public async Task<RefreshToken> FindToken(int userId, string refreshToken)
        {
            var dictionary = new Dictionary<string, object>
            {
                { "@userId", userId },
                { "@token", refreshToken }
            };
            
            using var conn = await ConnectionFactory.GetNewOpenConnection();
            return await conn.QuerySingleOrDefaultAsync<RefreshToken>("SELECT * from RefreshToken where UserId = @userId and Token = @token", dictionary);
        }
    }
}