using System;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class ParticipantAlreadyAddedException: Exception
    {
        public UserId UserId { get; }

        public ParticipantAlreadyAddedException(UserId userId)
        {
            UserId = userId;
        }
    }
}