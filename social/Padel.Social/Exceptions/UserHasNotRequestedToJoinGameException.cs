using System;

namespace Padel.Social.Exceptions
{
    public class UserHasNotRequestedToJoinGameException : Exception
    {
        public int    User   { get; }
        public string GameId { get; }

        public UserHasNotRequestedToJoinGameException(int user, string gameId, string msg = null) : base(msg)
        {
            User = user;
            GameId = gameId;
        }
    }
}