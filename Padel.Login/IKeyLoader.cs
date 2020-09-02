using System.Security.Cryptography;
using System.Threading.Tasks;

namespace Padel.Login
{
    public interface IKeyLoader
    {
        Task<(RSA PublicKey, RSA PrivateKey)> Load();
    }
}