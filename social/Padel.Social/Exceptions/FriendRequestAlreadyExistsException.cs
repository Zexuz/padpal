using System;

namespace Padel.Social.Exceptions
{
    public class FriendRequestAlreadyExistsException : Exception
    {
        public int FromUser { get; }
        public int ToUser   { get; }

        public FriendRequestAlreadyExistsException(int fromUser, int toUser)
        {
            FromUser = fromUser;
            ToUser = toUser;
        }
    }
}