using System;
using Padel.Social.ValueTypes;

namespace Padel.Social.Exceptions
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