using System;

namespace Padel.Social.Exceptions
{
    public class AlreadyRequestedToJoinedException : Exception
    {
        public int    UserId { get; }
        public string GameId { get; }

        public AlreadyRequestedToJoinedException(int userId, string gameId, string message) : base(message)
        {
            UserId = userId;
            GameId = gameId;
        }
    }
}