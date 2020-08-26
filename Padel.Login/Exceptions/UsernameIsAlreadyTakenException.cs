using System;

namespace Padel.Login.Exceptions
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