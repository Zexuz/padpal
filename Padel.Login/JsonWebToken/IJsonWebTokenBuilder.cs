using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Login.JsonWebToken
{
    public interface IJsonWebTokenBuilder
    {
        Task<T> DecodeToken<T>(string token);
        Task<string> Create(Dictionary<string, string> claims);
    }
}