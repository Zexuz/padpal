using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Identity.Services.JsonWebToken
{
    public interface IJsonWebTokenBuilder
    {
        Task<T> DecodeToken<T>(string token);
        Task<string> Create(Dictionary<string, object> claims);
    }
}