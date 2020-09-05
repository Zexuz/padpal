using System.Threading.Tasks;

namespace Padel.Login.Repositories.RefreshToken
{
    public interface IRefreshTokenRepository : IRepositoryBase<RefreshToken>
    {
        Task<RefreshToken?> FindToken(string refreshToken);
    }
}