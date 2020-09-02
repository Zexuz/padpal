using System;
using System.Threading.Tasks;
using FakeItEasy;
using Microsoft.Extensions.Logging;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.User;
using Padel.Login.Services;
using Xunit;
using User = Padel.Login.Repositories.User.User;

namespace Padel.Login.Test
{
    public class UserServiceTest
    {
        private readonly ILogger<UserService> _fakeLogger;
        private readonly IUserRepository      _fakeUserRepo;
        private readonly IPasswordService     _fakePasswordService;

        private readonly UserService _sut;

        public UserServiceTest()
        {
            _fakeLogger = A.Fake<ILogger<UserService>>();
            _fakeUserRepo = A.Fake<IUserRepository>();
            _fakePasswordService = A.Fake<IPasswordService>();

            _sut = new UserService(_fakeUserRepo, _fakePasswordService, _fakeLogger);
        }

        [Fact]
        public async Task Should_throw_exception_when_email_does_not_exists()
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));

            var loginRequest = new Proto.User.V1.LoginRequest
            {
                Email = "someEmail",
                Password = "plainPassword"
            };
            var ex = await Assert.ThrowsAsync<EmailDoesNotExistsException>(async () => await _sut.Login(loginRequest));
            Assert.Equal("someEmail", ex.Email);

            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s == "someEmail"))).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_throw_exception_when_password_does_not_match()
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(new User {PasswordHash = "somePasswordHash"}));
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(A<string>._, A<string>._)).Returns(false);

            var loginRequest = new Proto.User.V1.LoginRequest
            {
                Email = "someEmail",
                Password = "plainPassword"
            };
            var ex = await Assert.ThrowsAsync<PasswordDoesNotMatchException>(async () => await _sut.Login(loginRequest));
            Assert.Equal("someEmail", ex.Email);

            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s == "someEmail"))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(
                A<string>.That.Matches(s => s == "somePasswordHash"),
                A<string>.That.Matches(s => s == "plainPassword")
            )).MustHaveHappenedOnceExactly();
        }

        // TODO Expand this test to return JWT credentials
        [Fact]
        public async Task Should_do_nothing_if_successful()
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(new User {PasswordHash = "somePasswordHash"}));
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(A<string>._, A<string>._)).Returns(true);

            var loginRequest = new Proto.User.V1.LoginRequest
            {
                Email = "someEmail",
                Password = "plainPassword"
            };

            await _sut.Login(loginRequest);

            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s == "someEmail"))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(
                A<string>.That.Matches(s => s == "somePasswordHash"),
                A<string>.That.Matches(s => s == "plainPassword")
            )).MustHaveHappenedOnceExactly();
        }

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
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => _fakeUserRepo.FindByUsername(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => _fakePasswordService.GenerateHashFromPlanText(A<string>._)).Returns(hashedPassword);

            var user = new Padel.Proto.User.V1.User
            {
                Username = username,
                Password = plainPassword,
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                DateOfBirth = new Proto.User.V1.User.Types.Date
                {
                    Day = int.Parse(day),
                    Month = int.Parse(month),
                    Year = int.Parse(year)
                }
            };

            await _sut.RegisterNewUser(user);

            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s    == email))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.FindByUsername(A<string>.That.Matches(s => s == username))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.Insert(A<User>.That.Matches(u =>
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
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(new User()));

            var user = new Padel.Proto.User.V1.User
            {
                Email = email
            };

            var ex = await Assert.ThrowsAsync<EmailIsAlreadyTakenException>(() => _sut.RegisterNewUser(user));

            Assert.Equal(email, ex.Email);
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals(email)))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.FindByUsername(A<string>._)).MustNotHaveHappened();
            A.CallTo(() => _fakeUserRepo.Insert(A<User>._)).MustNotHaveHappened();
        }

        [Theory]
        [InlineData("username1")]
        [InlineData("userName23123")]
        public async Task Should_Throw_UsernameAlreadyInUseException(string username)
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => _fakeUserRepo.FindByUsername(A<string>._)).Returns(Task.FromResult(new User()));

            var user = new Padel.Proto.User.V1.User
            {
                Username = username,
                Email = "myemail"
            };

            var ex = await Assert.ThrowsAsync<UsernameIsAlreadyTakenException>(() => _sut.RegisterNewUser(user));

            Assert.Equal(username, ex.Username);
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals(user.Email)))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.FindByUsername(A<string>.That.Matches(s => s.Equals(username)))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.Insert(A<User>._)).MustNotHaveHappened();
        }
    }
}