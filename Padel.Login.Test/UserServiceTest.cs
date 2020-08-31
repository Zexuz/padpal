using System.Threading.Tasks;
using FakeItEasy;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.User;
using Padel.Login.Services;
using Xunit;

namespace Padel.Login.Test
{
    public class UserServiceTest
    {
        // TODO
        // [X] Creat a user service, that the GRPC registerUser calls.
        // [X] In that, verifies that the users email and username dos not already exist
        // [X] If it does not, Add the new user.
        // [X] Hash the password.
        // [ ] And publish a new event that says a new user has been created.
        [Theory]
        [InlineData("zexyz", "PlainTextPassword", "Robin", "Edbom", "myEmail@mkdir.se", "7", "11", "1996", "$10000.salt.hash")]
        [InlineData("username", "passWord", "Jane", "Doe", "jane@doe.org", "1", "1", "1900", "$10000.salt.someOtherhash")]
        public async Task Should_Add_New_User_To_Table(
            string username,
            string plainPassword,
            string firstName,
            string lastName,
            string email,
            string day,
            string month,
            string year,
            string hashedPassword
        )
        {
            var fakeUserRepo = A.Fake<IUserRepository>();
            var fakePasswordService = A.Fake<IPasswordService>();

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => fakePasswordService.GenerateHashFromPlanText(A<string>._)).Returns(hashedPassword);

            var user = new Proto.User.User
            {
                Username = username,
                Password = plainPassword,
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                DateOfBirth = new Proto.User.User.Types.Date
                {
                    Day = int.Parse(day),
                    Month = int.Parse(month),
                    Year = int.Parse(year)
                }
            };
            var service = new UserService(fakeUserRepo, fakePasswordService);

            await service.RegisterNewUser(user);

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s    == email))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>.That.Matches(s => s == username))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.Insert(A<User>.That.Matches(u =>
                u.Email                  == email            &&
                u.Username               == username         &&
                u.FirstName              == firstName        &&
                u.LastName               == lastName         &&
                u.PasswordHash           == hashedPassword   &&
                u.DateOfBirth.Date.Day   == int.Parse(day)   &&
                u.DateOfBirth.Date.Month == int.Parse(month) &&
                u.DateOfBirth.Date.Year  == int.Parse(year)
            ))).MustHaveHappenedOnceExactly();
        }

        [Theory]
        [InlineData("someemail@mkdir.se")]
        [InlineData("sonme-other-email@mkdir.se")]
        public async Task Should_Throw_EmailAlreadyInUseException(string email)
        {
            var fakeUserRepo = A.Fake<IUserRepository>();
            var fakePasswordService = A.Fake<IPasswordService>();


            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(new User()));

            var user = new Proto.User.User
            {
                Email = email
            };
            var service = new UserService(fakeUserRepo, fakePasswordService);

            var ex = await Assert.ThrowsAsync<EmailIsAlreadyTakenException>(() => service.RegisterNewUser(user));
            Assert.Equal(email, ex.Email);

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals(email)))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>._)).MustNotHaveHappened();
            A.CallTo(() => fakeUserRepo.Insert(A<User>._)).MustNotHaveHappened();
        }

        [Theory]
        [InlineData("username1")]
        [InlineData("userName23123")]
        public async Task Should_Throw_UsernameAlreadyInUseException(string username)
        {
            var fakeUserRepo = A.Fake<IUserRepository>();
            var fakePasswordService = A.Fake<IPasswordService>();

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>._)).Returns(Task.FromResult(new User()));

            var user = new Proto.User.User
            {
                Username = username,
                Email = "myemail"
            };
            var service = new UserService(fakeUserRepo, fakePasswordService);

            var ex = await Assert.ThrowsAsync<UsernameIsAlreadyTakenException>(() => service.RegisterNewUser(user));
            Assert.Equal(username, ex.Username);

            A.CallTo(() => fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals(user.Email)))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.FindByUsername(A<string>.That.Matches(s => s.Equals(username)))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeUserRepo.Insert(A<User>._)).MustNotHaveHappened();
        }
    }
}