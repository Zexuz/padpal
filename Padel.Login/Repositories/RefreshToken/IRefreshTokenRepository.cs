using System;
using System.Threading.Tasks;

namespace Padel.Login.Repositories.RefreshToken
{
    public interface IRefreshTokenRepository : IRepositoryBase<RefreshToken>
    {
        Task<bool> UpdateLastUsed(in int userId, string refreshToken, ConnectionInfo info);
        Task<RefreshToken> FindToken(int userId, string refreshToken, ConnectionInfo info);
    }
}