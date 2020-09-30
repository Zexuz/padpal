using System;

namespace Padel.Identity.Exceptions
{
    public class EmailDoesNotExistsException : Exception
    {
        public string Email { get; }

        public EmailDoesNotExistsException(string email)
        {
            Email = email;
        }
    }
}