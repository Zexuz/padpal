using System.Collections.Generic;
using System.Security.Cryptography;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Identity.Services;
using Padel.Identity.Services.JsonWebToken;
using Xunit;

namespace Padel.Identity.Runner.Test.Unit
{
    public class JsonWebTokenBuilderTest
    {
        [Fact]
        public async Task Should_create_valid_tokens()
        {
            var rsaGenerator = RSA.Create(2048);

            var fakeKeyLoader = A.Fake<IKeyLoader>();

            A.CallTo(() => fakeKeyLoader.Load()).Returns((rsaGenerator, rsaGenerator));

            var claims = new Dictionary<string, object>
            {
                {"name", "robin"},
                {"asInt", 1337}
            };

            var jwt = new JsonWebTokenBuilder(fakeKeyLoader);

            var token = await jwt.Create(claims);

            var decodeToken = await jwt.DecodeToken<Dictionary<string, object>>(token);
            Assert.Equal("robin", decodeToken["name"]);
            Assert.Equal((long)1337, decodeToken["asInt"]);
        }

        [Fact]
        public async Task Should_throw_exception_keys_are_invalid()
        {
            var rsaGenerator = RSA.Create(2048);
            var rsaGenerator1 = RSA.Create(2048);

            var fakeKeyLoader = A.Fake<IKeyLoader>();

            A.CallTo(() => fakeKeyLoader.Load()).Returns((rsaGenerator, rsaGenerator1));

            var claims = new Dictionary<string, object>
            {
                {"name", "robin"}
            };

            var jwt = new JsonWebTokenBuilder(fakeKeyLoader);

            var token = await jwt.Create(claims);

            await Assert.ThrowsAsync<JWT.Exceptions.SignatureVerificationException>(async () =>
                await jwt.DecodeToken<Dictionary<string, string>>(token));
        }
    }
}