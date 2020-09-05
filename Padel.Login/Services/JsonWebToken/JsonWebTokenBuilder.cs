using System.Collections.Generic;
using System.Threading.Tasks;
using JWT.Algorithms;
using JWT.Builder;

namespace Padel.Login.Services.JsonWebToken
{
    public class JsonWebTokenBuilder : IJsonWebTokenBuilder
    {
        private readonly IKeyLoader _keyLoader;

        public JsonWebTokenBuilder(IKeyLoader keyLoader)
        {
            _keyLoader = keyLoader;
        }

        public async Task<T> DecodeToken<T>(string token)
        {
            // TODO We should cache the key or something, it's not good that everytime we decode a token must read from file storage
            var (publicKey, _) = await _keyLoader.Load();

            var json = new JwtBuilder()
                .WithAlgorithm(new RS256Algorithm(publicKey))
                .MustVerifySignature()
                .Decode<T>(token);

            return json;
        }

        public async Task<string> Create(Dictionary<string, string> claims)
        {
            // TODO We should cache the key or something, it's not good that everytime we decode a token must read from file storage
            var (publicKey, privateKey) = await _keyLoader.Load();

            var tokenBuilder = new JwtBuilder()
                .WithAlgorithm(new RS256Algorithm(publicKey, privateKey))
                .MustVerifySignature();

            foreach (var (key, value) in claims)
                tokenBuilder.AddClaim(key, value);

            return tokenBuilder.Encode();
        }
    }
}