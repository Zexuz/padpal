using System;

namespace Padel.Social.Exceptions
{
    public class NoMatchingFriendRequestFoundException : Exception
    {
        public int FromUser { get; }
        public int ToUser   { get; }

        public NoMatchingFriendRequestFoundException(int fromUser, int toUser)
        {
            FromUser = fromUser;
            ToUser = toUser;
        }
    }
}