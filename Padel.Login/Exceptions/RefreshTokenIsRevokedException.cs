using System;

namespace Padel.Login.Exceptions
{
    public class RefreshTokenIsRevokedException : Exception
    {
        public int TokenId { get; }
        public string Ip { get; }

        public RefreshTokenIsRevokedException(int tokenId, ConnectionInfo info)
        {
            TokenId = tokenId;
            Ip = info.Ip;
        }
    }
}