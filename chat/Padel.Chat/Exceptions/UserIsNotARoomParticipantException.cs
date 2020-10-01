using System;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Exceptions
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