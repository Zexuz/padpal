using System;

namespace Padel.Social.Exceptions
{
    public class AlreadyFriendsException : Exception
    {
        public int FromUser { get; }
        public int ToUser   { get; }

        public AlreadyFriendsException(int fromUser, int toUser)
        {
            FromUser = fromUser;
            ToUser = toUser;
        }
    }
}