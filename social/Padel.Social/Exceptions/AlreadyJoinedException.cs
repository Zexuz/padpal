using System;

namespace Padel.Social.Exceptions
{
    public class AlreadyJoinedException : Exception
    {
        public int    UserId { get; }
        public string GameId { get; }

        public AlreadyJoinedException(int userId, string gameId, string message) : base(message)
        {
            UserId = userId;
            GameId = gameId;
        }
    }
}