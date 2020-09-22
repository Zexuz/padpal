using System;

namespace Padel.Identity.Exceptions
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