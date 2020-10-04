using System;
using Padel.Social.ValueTypes;

namespace Padel.Social.Exceptions
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