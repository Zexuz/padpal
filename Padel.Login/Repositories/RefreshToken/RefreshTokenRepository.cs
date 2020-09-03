namespace Padel.Login.Repositories.RefreshToken
{
    public class RefreshTokenRepository : RepositoryBase<RefreshToken>, IRefreshTokenRepository
    {
        public RefreshTokenRepository(IDatabaseConnectionFactory connectionFactory) : base(connectionFactory)
        {
        }
    }
}