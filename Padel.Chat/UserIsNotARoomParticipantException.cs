using System;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class UserIsNotARoomParticipantException : Exception
    {
        public UserId UserId { get; }

        public UserIsNotARoomParticipantException(UserId userId)
        {
            UserId = userId;
        }
    }
}