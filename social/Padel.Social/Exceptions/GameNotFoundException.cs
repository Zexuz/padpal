using System;

namespace Padel.Social.Exceptions
{
    public class GameNotFoundException : Exception
    {
        public string GameId { get; }

        public GameNotFoundException(string gameId, string message = null): base(message)
        {
            GameId = gameId;
        }
    }
}