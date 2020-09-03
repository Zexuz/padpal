using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Login.Repositories.User;

namespace Padel.Login.Services.JsonWebToken
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

        public async Task<string> CreateNewAccessToken(User user)
        {
            var exp = DateTimeOffset.UtcNow.Add(_options.LifeSpan);

            var claims = new Dictionary<string, string>
            {
                {"exp", exp.ToUnixTimeSeconds().ToString()},
                {"sub", user.Id.ToString()},
            };

            return await _builder.Create(claims);
        }
    }
}