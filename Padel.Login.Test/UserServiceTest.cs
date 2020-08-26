using System.Threading.Tasks;
using FakeItEasy;
using Xunit;

namespace Padel.Login.Test
{
    public class UserServiceTest
    {
        // TODO
        // Creat a user service, that the GRPC registerUser calls.
        // In that, verifies that the users email and username dos not already exist
        // If it does not, Add the new user.
        // And publish a new event that says a new user has been created.
        [Fact]
        public async Task Should_Add_New_User_To_Table()
        {
            var fakeUserRepo = A.Fake<IUserRepository>();

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>._)).Returns(Task.FromResult<User>(null!));

            var user = new User();
            var service = new UserService(fakeUserRepo);

            await service.RegisterNewUser(user);

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals("robin.edbom@gmail.com")))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>.That.Matches(s => s.Equals("zexuz")))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.Insert(A<User>.That.Matches(u => u.DeepCompare(user)))).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_Throw_EmailAlreadyInUseException()
        {
            var fakeUserRepo = A.Fake<IUserRepository>();

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(new User()));

            var user = new User();
            var service = new UserService(fakeUserRepo);

            var ex = await Assert.ThrowsAsync<EmailIsAlreadyTakenException>(() => service.RegisterNewUser(user));
            Assert.Equal("robin.edbom@gmail.com", ex.Email);

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals("robin.edbom@gmail.com")))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>._)).MustNotHaveHappened();
            A.CallTo(() => fakeUserRepo.Insert(A<User>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_Throw_UsernameAlreadyInUseException()
        {
            var fakeUserRepo = A.Fake<IUserRepository>();

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>._)).Returns(Task.FromResult(new User()));

            var user = new User();
            var service = new UserService(fakeUserRepo);

            var ex = await Assert.ThrowsAsync<UsernameIsAlreadyTakenException>(() => service.RegisterNewUser(user));
            Assert.Equal("zexuz", ex.Username);

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals("robin.edbom@gmail.com")))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>.That.Matches(s => s.Equals("zexuz")))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.Insert(A<User>._)).MustNotHaveHappened();
        }
    }
}