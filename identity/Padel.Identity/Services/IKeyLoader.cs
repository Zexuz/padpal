using System.Security.Cryptography;
using System.Threading.Tasks;

namespace Padel.Identity.Services
{
    public interface IKeyLoader
    {
        // TODO, it is only in this application (Identity) that we want the private key, in all other application, we might only want the public to (In order to validate the token)
        Task<(RSA PublicKey, RSA PrivateKey)> Load();
    }
}