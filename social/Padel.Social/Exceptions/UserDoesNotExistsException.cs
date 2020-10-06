using System;

namespace Padel.Social.Exceptions
{
    public class UserDoesNotExistsException : Exception
    {
        public int User { get; }

        public UserDoesNotExistsException(int user)
        {
            User = user;
        }
    }
}