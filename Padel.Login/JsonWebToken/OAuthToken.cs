using System;

namespace Padel.Login.JsonWebToken
{
    public class OAuthToken
    {
        public string AccessToken { get; set; }
        public DateTimeOffset Expires { get; set; }
        public OAuthTokenType Type { get; set; }
        public string RefreshToken { get; set; }

        public enum OAuthTokenType
        {
            Bearer
        }
    }
}