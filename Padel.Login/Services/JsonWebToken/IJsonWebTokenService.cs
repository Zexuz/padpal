using System;
using System.Threading.Tasks;

namespace Padel.Login.Services.JsonWebToken
{
    public interface IJsonWebTokenService
    {
        Task<(string token, DateTimeOffset expires)> CreateNewAccessToken(int userId);
    }
}