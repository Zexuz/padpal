using System;
using System.Security.Cryptography;

namespace Padel.Identity.Services
{
    public class PasswordService : IPasswordService
    {
        private const int Iterations = 100000;
        private const int SaltSize   = 32;
        private const int HashSize   = 64;

        public string GenerateHashFromPlanText(string password)
        {
            var passwordBytes = new Rfc2898DeriveBytes(password, SaltSize, Iterations);
            return Format(Iterations, passwordBytes, HashSize);
        }

        public bool IsPasswordOfHash(string passwordHash, string plainPassword)
        {
            var parts = passwordHash.Split('.');

            var usedIterations = int.Parse(parts[0]);
            var usedSalt = Convert.FromBase64String(parts[1]);
            var usedHash = Convert.FromBase64String(parts[2]);

            var passwordBytes = new Rfc2898DeriveBytes(plainPassword, usedSalt, usedIterations);

            return Format(usedIterations, passwordBytes, usedHash.Length) == passwordHash;
        }


        private static string Format(int iterations, Rfc2898DeriveBytes passwordBytes, int hashSize)
        {
            var hash = passwordBytes.GetBytes(hashSize);
            var salt = passwordBytes.Salt;

            return $"{iterations}.{Convert.ToBase64String(salt)}.{Convert.ToBase64String(hash)}";
        }
    }
}