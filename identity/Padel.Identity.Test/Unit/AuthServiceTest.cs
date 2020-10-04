using System;
using System.Threading.Tasks;
using FakeItEasy;
using Microsoft.Extensions.Logging;
using Padel.Identity.Exceptions;
using Padel.Identity.Repositories.User;
using Padel.Identity.Services;
using Padel.Proto.Auth.V1;
using Padel.Queue;
using Xunit;
using AuthService = Padel.Identity.Services.AuthService;
using NewUser = Padel.Identity.Models.NewUser;
using OAuthToken = Padel.Identity.Services.JsonWebToken.OAuthToken;
using SignInRequest = Padel.Identity.Models.SignInRequest;

namespace Padel.Identity.Test.Unit
{
    public class AuthServiceTest
    {
        private readonly ILogger<AuthService> _fakeLogger;
        private readonly IUserRepository      _fakeUserRepo;
        private readonly IPasswordService     _fakePasswordService;
        private readonly IOAuthTokenService   _fakeAuthTokenService;
        private readonly IPublisher           _fakePublisher;

        private readonly AuthService _sut;

        public AuthServiceTest()
        {
            _fakeLogger = A.Fake<ILogger<AuthService>>();
            _fakeUserRepo = A.Fake<IUserRepository>();
            _fakePasswordService = A.Fake<IPasswordService>();
            _fakeAuthTokenService = A.Fake<IOAuthTokenService>();
            _fakePublisher = A.Fake<IPublisher>();

            _sut = new AuthService(_fakeUserRepo, _fakePasswordService, _fakeLogger, _fakeAuthTokenService, _fakePublisher);
        }

        [Fact]
        public async Task Should_throw_exception_when_email_does_not_exists()
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));

            var singInRequest = new SignInRequest
            {
                Email = "someEmail",
                Password = "plainPassword",
            };
            var ex = await Assert.ThrowsAsync<EmailDoesNotExistsException>(async () => await _sut.SignIn(singInRequest, new ConnectionInfo()));
            Assert.Equal("someEmail", ex.Email);

            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s == "someEmail"))).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_throw_exception_when_password_does_not_match()
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(new User {PasswordHash = "somePasswordHash"}));
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(A<string>._, A<string>._)).Returns(false);

            var signInRequest = new SignInRequest
            {
                Email = "someEmail",
                Password = "plainPassword",
            };
            var ex = await Assert.ThrowsAsync<PasswordDoesNotMatchException>(async () => await _sut.SignIn(signInRequest, new ConnectionInfo()));
            Assert.Equal("someEmail", ex.Email);

            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s == "someEmail"))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(
                A<string>.That.Matches(s => s == "somePasswordHash"),
                A<string>.That.Matches(s => s == "plainPassword")
            )).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_return_OAuthToken_if_successful()
        {
            var dbUser = new User {PasswordHash = "somePasswordHash", Id = 1, Email = "someEmail"};
            var connectionInfo = new ConnectionInfo {Ip = "myIp"};
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(dbUser));
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(A<string>._, A<string>._)).Returns(true);
            A.CallTo(() => _fakeAuthTokenService.CreateNewRefreshToken(A<int>._, A<ConnectionInfo>._)).Returns(
                Task.FromResult(new OAuthToken
                {
                    AccessToken = "some.jwt.token"
                })
            );

            var signInRequest = new SignInRequest
            {
                Email = "someEmail",
                Password = "plainPassword",
            };

            var token = await _sut.SignIn(signInRequest, connectionInfo);

            Assert.Equal("some.jwt.token", token.AccessToken);

            A.CallTo(() => _fakeAuthTokenService.CreateNewRefreshToken(
                    1,
                    A<ConnectionInfo>.That.Matches(info => info.Ip == "myIp"))
                )
                .MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s == "someEmail"))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakePasswordService.IsPasswordOfHash(
                A<string>.That.Matches(s => s == "somePasswordHash"),
                A<string>.That.Matches(s => s == "plainPassword")
            )).MustHaveHappenedOnceExactly();
        }

        [Theory]
        [InlineData("PlainTextPassword", "Robin Edbom", "myEmail@mkdir.se", "7", "11", "1996", "$10000.salt.hash")]
        [InlineData("passWord", "Jane Doe", "jane@doe.org", "1", "1", "1900", "$10000.salt.someOtherhash")]
        public async Task Should_add_new_user_to_table(
            string plainPassword,
            string name,
            string email,
            string day,
            string month,
            string year,
            string hashedPassword
        )
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult<User>(null!));
            A.CallTo(() => _fakePasswordService.GenerateHashFromPlanText(A<string>._)).Returns(hashedPassword);

            var user = new NewUser
            {
                Password = plainPassword,
                Name = name,
                Email = email,
                DateOfBirth = new DateTime(int.Parse(year), int.Parse(month), int.Parse(day))
            };

            await _sut.RegisterNewUser(user);

            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s == email))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.Insert(A<User>.That.Matches(u =>
                u.Email                  == email            &&
                u.Name                   == name             &&
                u.PasswordHash           == hashedPassword   &&
                u.DateOfBirth.Date.Day   == int.Parse(day)   &&
                u.DateOfBirth.Date.Month == int.Parse(month) &&
                u.DateOfBirth.Date.Year  == int.Parse(year)
            ))).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakePublisher.PublishMessage(A<UserSignUpMessage>.That.Matches(up => up.Name == name))).MustHaveHappenedOnceExactly();
        }

        [Theory]
        [InlineData("someemail@mkdir.se")]
        [InlineData("sonme-other-email@mkdir.se")]
        public async Task Should_throw_emailAlreadyInUseException(string email)
        {
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>._)).Returns(Task.FromResult(new User()));

            var user = new NewUser
            {
                Email = email
            };

            var ex = await Assert.ThrowsAsync<EmailIsAlreadyTakenException>(() => _sut.RegisterNewUser(user));

            Assert.Equal(email, ex.Email);
            A.CallTo(() => _fakeUserRepo.FindByEmail(A<string>.That.Matches(s => s.Equals(email)))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeUserRepo.Insert(A<User>._)).MustNotHaveHappened();
        }
    }
}