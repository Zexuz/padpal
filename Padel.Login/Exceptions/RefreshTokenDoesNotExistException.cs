using System;

namespace Padel.Login.Exceptions
{
    public class RefreshTokenDoesNotExistException : Exception
    {
        public string RefreshToken { get; }
        public string Ip { get; }

        public RefreshTokenDoesNotExistException(string refreshToken, ConnectionInfo info)
        {
            RefreshToken = refreshToken;
            Ip = info.Ip;
        }
    }
}