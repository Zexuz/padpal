using System;
using System.IO;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace Padel.Login
{
    public class KeyLoader
    {
        private readonly IFileService _fileService;

        public KeyLoader(IFileService fileService)
        {
            _fileService = fileService;
        }

        public async Task<(string PublicKey, string PrivateKey)> Load()
        {
            var basePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "padel");
            var publicKeyPath = Path.Combine(basePath, "public.txt");
            var privateKeyPath = Path.Combine(basePath, "private.txt");

            if (!_fileService.DoesFileExist(publicKeyPath) || !_fileService.DoesFileExist(privateKeyPath))
            {
                var rsa = RSA.Create(2048);
                await _fileService.WriteAllBytesAsync(publicKeyPath, rsa.ExportSubjectPublicKeyInfo());
                await _fileService.WriteAllBytesAsync(privateKeyPath, rsa.ExportRSAPrivateKey());
            }

            var pubKey = await _fileService.ReadAllLines(publicKeyPath);
            var priKey = await _fileService.ReadAllLines(privateKeyPath);
            return (pubKey, priKey);
        }
    }
}