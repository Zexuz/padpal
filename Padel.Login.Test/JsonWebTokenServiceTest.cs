using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Login.JsonWebToken;
using Padel.Login.Repositories.User;
using Xunit;

namespace Padel.Login.Test
{
    public class JsonWebTokenServiceTest
    {
        private readonly JsonWebTokenService        _sut;
        private readonly IJsonWebTokenBuilder       _fakeJsonWebTokenBuilder;
        private readonly JsonWebTokenServiceOptions _options;

        public JsonWebTokenServiceTest()
        {
            _fakeJsonWebTokenBuilder = A.Fake<IJsonWebTokenBuilder>();

            _options = new JsonWebTokenServiceOptions
            {
                LifeSpan = TimeSpan.FromMinutes(30)
            };

            _sut = new JsonWebTokenService(_fakeJsonWebTokenBuilder, _options);
        }

        [Fact]
        public async Task Should_create_token_with_correct_claims()
        {
            var user = new User
            {
                Id = 1337,
            };
            await _sut.CreateNewAccessToken(user);

            A.CallTo(() => _fakeJsonWebTokenBuilder.Create(A<Dictionary<string, string>>.That.Matches(dict =>
                (DateTimeOffset.FromUnixTimeSeconds(long.Parse(dict["exp"])) - DateTimeOffset.UtcNow) - _options.LifeSpan < TimeSpan.FromSeconds(1) &&
                dict["sub"]                                                                                               == "1337"
            ))).MustHaveHappenedOnceExactly();
        }
    }
}