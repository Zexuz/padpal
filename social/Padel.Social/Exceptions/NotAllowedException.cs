using System;

namespace Padel.Social.Exceptions
{
    public class NotAllowedException : Exception
    {
        public NotAllowedException(string msg = null) : base(msg)
        {
        }
    }
}