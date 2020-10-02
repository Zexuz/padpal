using System;
using System.Security.Cryptography;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Identity.Runner.Controllers;
using Padel.Identity.Services;
using Padel.Proto.Auth.V1;
using Padel.Test.Core;
using Xunit;

namespace Padel.Identity.Test.Unit.Controllers
{
    public class AuthControllerV1Test : TestControllerBase
    {
        private          AuthControllerV1 _sut;
        private readonly IAuthService     _fakeAuthService;
        private          IKeyLoader       _fakeKeyLoader;

        public AuthControllerV1Test()
        {
            _fakeKeyLoader = A.Fake<IKeyLoader>();
            _fakeAuthService = A.Fake<IAuthService>();
            _sut = new AuthControllerV1(_fakeAuthService, _fakeKeyLoader);
        }


        [Theory]
        [InlineData("")]
        public void Should_throw_exception_if_invalid_requestparams(string str)
        {
            Assert.False(true);
        }

        [Fact]
        public async Task Should_return_public_key()
        {
            var keys = (RSA.Create(), RSA.Create());
            var jwtKey = Convert.ToBase64String(keys.Item1.ExportRSAPublicKey());
            A.CallTo(() => _fakeKeyLoader.Load()).Returns(Task.FromResult(keys));

            var res = await _sut.GetPublicJwtKey(new GetPublicJwtKeyRequest(), CreateServerCallContextWithNo());
            
            Assert.Equal(jwtKey, res.PublicRsaKey);
            A.CallTo(() => _fakeKeyLoader.Load()).MustHaveHappenedOnceExactly();
        }
    }
}