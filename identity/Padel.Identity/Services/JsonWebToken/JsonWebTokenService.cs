using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Identity.Services.JsonWebToken
{
    public class JsonWebTokenService : IJsonWebTokenService
    {
        private readonly IJsonWebTokenBuilder       _builder;
        private readonly JsonWebTokenServiceOptions _options;

        public JsonWebTokenService(IJsonWebTokenBuilder builder, JsonWebTokenServiceOptions options)
        {
            _builder = builder;
            _options = options;
        }

        public async Task<(string token, DateTimeOffset expires)> CreateNewAccessToken(int userId)
        {
            var exp = DateTimeOffset.UtcNow.Add(_options.LifeSpan);

            var claims = new Dictionary<string, object>
            {
                {"exp", exp.ToUnixTimeSeconds()},
                {"sub", userId.ToString()}
            };

            return (await _builder.Create(claims), exp);
        }
    }
}