using System;
using System.Security.Cryptography;

namespace Padel.Identity
{
    public class CustomRandom : IRandom
    {
        public string GenerateSecureString(int length)
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[length];
            provider.GetBytes(byteArray);

            var randomString = Convert.ToBase64String(byteArray, 0);

            return randomString;
        }
    }
}