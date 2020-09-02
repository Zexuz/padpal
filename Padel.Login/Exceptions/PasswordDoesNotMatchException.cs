using System;

namespace Padel.Login.Exceptions
{
    public class PasswordDoesNotMatchException : Exception
    {
        public string Email { get; }

        public PasswordDoesNotMatchException(string email)
        {
            Email = email;
        }
    }
}