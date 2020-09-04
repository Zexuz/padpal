using System.Threading.Tasks;

namespace Padel.Login.Repositories.RefreshToken
{
    public class RefreshTokenRepository : RepositoryBase<RefreshToken>, IRefreshTokenRepository
    {
        public RefreshTokenRepository(IDatabaseConnectionFactory connectionFactory) : base(connectionFactory)
        {
        }

        public Task<RefreshToken> FindToken(int userId, string refreshToken, ConnectionInfo info)
        {
            throw new System.NotImplementedException();
        }

        Task<bool> IRefreshTokenRepository.UpdateLastUsed(in int userId, string refreshToken, ConnectionInfo info)
        {
            throw new System.NotImplementedException();
        }
    }
}