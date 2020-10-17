using System;

namespace Padel.Social.Exceptions
{
    public class NotFriendsException : Exception
    {
        public NotFriendsException(string msg) : base(msg)
        {
        }
    }
}