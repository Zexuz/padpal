using System;

namespace Padel.Social.Exceptions
{
    public class ConversationAlreadyExistsException : Exception
    {
        public int FromUser { get; }
        public int ToUser   { get; }

        public ConversationAlreadyExistsException(int fromUser, int toUser)
        {
            FromUser = fromUser;
            ToUser = toUser;
        }
    }
}