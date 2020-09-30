using System;
using System.Linq;

namespace Padel.Test.Core
{
    public static class StringGenerator
    {
        private static readonly Random _random = new Random();

        public const string Letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        public const string Digits  = "123456789";

        public static string RandomEmail()
        {
            return RandomString(10, Letters) + "@gmail.com";
        }

        public static string RandomPassword()
        {
            return RandomString(10);
        }


        public static string RandomString(int length, string chars = Letters + Digits)
        {
            return new string(Enumerable.Repeat(chars, length).Select(s => s[_random.Next(s.Length)]).ToArray());
        }
    }
}