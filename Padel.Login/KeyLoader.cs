using System;
using System.IO;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace Padel.Login
{
    public class KeyLoader : IKeyLoader
    {
        private readonly IFileService _fileService;

        public KeyLoader(IFileService fileService)
        {
            _fileService = fileService;
        }


        public async Task<(RSA PublicKey, RSA PrivateKey)> Load()
        {
            var basePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "padel");
            var publicKeyPath = Path.Combine(basePath, "public.txt");
            var privateKeyPath = Path.Combine(basePath, "private.txt");

            if (!Directory.Exists(basePath))
            {
                Directory.CreateDirectory(basePath);
            }

            if (!_fileService.DoesFileExist(publicKeyPath) || !_fileService.DoesFileExist(privateKeyPath))
            {
                var rsaGenerator = RSA.Create(2048);
                await _fileService.WriteAllText(publicKeyPath, Convert.ToBase64String(rsaGenerator.ExportSubjectPublicKeyInfo()));
                await _fileService.WriteAllText(privateKeyPath, Convert.ToBase64String(rsaGenerator.ExportRSAPrivateKey()));
            }

            var pubKey = RSA.Create();
            pubKey.ImportSubjectPublicKeyInfo(Convert.FromBase64String(await _fileService.ReadAllText(publicKeyPath)), out _);

            var priKey = RSA.Create();
            priKey.ImportRSAPrivateKey(Convert.FromBase64String(await _fileService.ReadAllText(privateKeyPath)), out _);
            return (pubKey, priKey);
        }
    }
}