using System.Threading.Tasks;
using FakeItEasy;
using Padel.Identity.Repositories.User;
using Padel.Identity.Runner.Controllers;
using Padel.Proto.User.V1;
using Padel.Test.Core;
using Xunit;

namespace Padel.Identity.Test.Unit.Controllers
{
    public class UserControllerV1Test : TestControllerBase
    {
        private          UserControllerV1 _sut;
        private readonly IUserRepository  _fakeUserRepository;

        public UserControllerV1Test()
        {
            _fakeUserRepository = A.Fake<IUserRepository>();
            _sut = new UserControllerV1(_fakeUserRepository);
        }

        [Fact]
        public async Task Me_should_return_currentUser_data()
        {
            A.CallTo(() => _fakeUserRepository.Get(10)).Returns(Task.FromResult(new User
            {
                Email = "robin@email.com",
                Name = "robin edbom",
            }));

            var ctx = CreateServerCallContextWithUserId(10);

            _sut = new UserControllerV1(_fakeUserRepository);

            var res = await _sut.Me(new MeRequest(), ctx);

            Assert.Equal("robin@email.com", res.Me.Email);
            Assert.Equal("robin edbom", res.Me.Name);
        }

        [Theory]
        [InlineData("")]
        public void Should_throw_exception_if_invalid_requestparams(string str)
        {
            // TODO THIS is also in the AuthController!!!
            Assert.False(true);
        }
    }
}