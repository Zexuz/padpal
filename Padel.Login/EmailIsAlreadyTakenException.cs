using System;

namespace Padel.Login.Test
{
    public class EmailIsAlreadyTakenException : Exception
    {
        public string Email { get; }

        public EmailIsAlreadyTakenException(string email)
        {
            Email = email;
        }
    }
}