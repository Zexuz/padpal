using System;

namespace Padel.Social.Exceptions
{
    public class GameAlreadyClosedException : Exception
    {
        public GameAlreadyClosedException(string msg) : base(msg)
        {
        }
    }
}