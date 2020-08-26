using System;

namespace Padel.Login.Test
{
    public class UsernameIsAlreadyTakenException : Exception
    {
        public string Username { get; }

        public UsernameIsAlreadyTakenException(string username)
        {
            Username = username;
        }
    }
}