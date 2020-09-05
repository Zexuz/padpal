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

        public async Task<RefreshToken?> FindToken(string refreshToken)
        {
            var dictionary = new Dictionary<string, object>
            {
                {"@token", refreshToken}
            };

            using var conn = await ConnectionFactory.GetNewOpenConnection();
            return await conn.QuerySingleOrDefaultAsync<RefreshToken>("SELECT * from RefreshToken where Token = @token", dictionary);
        }
    }
}