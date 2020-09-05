using System.Threading.Tasks;
using FakeItEasy;
using Padel.Login.Repositories.User;
using Padel.Proto.User.V1;
using Padel.Runner.Controllers;
using Xunit;

namespace Padel.Runner.Test.Controllers
{
    public class UserControllerV1Test : TestControllerBase
    {
        [Fact]
        public async Task Me_should_return_currentUser_data()
        {
            var fakeUserRepository = A.Fake<IUserRepository>();
            A.CallTo(() => fakeUserRepository.Get(10)).Returns(Task.FromResult(new User
            {
                Email = "robin@email.com",
                Username = "myUsername",
                FirstName = "robin",
                LastName = "edbom"
            }));

            var ctx = CreateServerCallContextWithUserId(10);

            var controller = new UserControllerV1(fakeUserRepository);

            var res = await controller.Me(new MeRequest(), ctx);

            Assert.Equal("robin@email.com", res.Me.Email);
            Assert.Equal("myUsername", res.Me.Username);
            Assert.Equal("robin", res.Me.FirstName);
            Assert.Equal("edbom", res.Me.LastName);
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