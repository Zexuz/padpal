using System;
using System.Threading.Tasks;
using Padel.Login.Repositories.User;

namespace Padel.Login.Services.JsonWebToken
{
    public interface IJsonWebTokenService
    {
        Task<(string token, DateTimeOffset expires)> CreateNewAccessToken(int userId);
    }
}