using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Identity.Exceptions;
using Padel.Identity.Repositories.User;
using Padel.Proto.Auth.V1;
using Padel.Queue;
using NewUser = Padel.Identity.Models.NewUser;
using OAuthToken = Padel.Identity.Services.JsonWebToken.OAuthToken;
using SignInRequest = Padel.Identity.Models.SignInRequest;

namespace Padel.Identity.Services
{
    public class AuthService : IAuthService
    {
        private readonly IUserRepository      _userRepository;
        private readonly IPasswordService     _passwordService;
        private readonly ILogger<AuthService> _logger;
        private readonly IOAuthTokenService   _oAuthTokenService;
        private readonly IPublisher           _publisher;

        public AuthService(
            IUserRepository      userRepository,
            IPasswordService     passwordService,
            ILogger<AuthService> logger,
            IOAuthTokenService   oAuthTokenService,
            IPublisher           publisher
        )
        {
            _userRepository = userRepository;
            _passwordService = passwordService;
            _logger = logger;
            _oAuthTokenService = oAuthTokenService;
            _publisher = publisher;
        }

        public async Task RegisterNewUser(NewUser user)
        {
            var resultByEmail = await _userRepository.FindByEmail(user.Email)!;
            if (resultByEmail != null)
            {
                _logger.LogError($"User with email {user.Email} already exists");
                throw new EmailIsAlreadyTakenException(user.Email);
            }

            var hashedPassword = _passwordService.GenerateHashFromPlanText(user.Password);

            var userId = await _userRepository.Insert(new User
            {
                Email = user.Email,
                PasswordHash = hashedPassword,
                Name = user.Name,
                DateOfBirth = user.DateOfBirth,
                Created = DateTimeOffset.UtcNow
            });
            await _publisher.PublishMessage(new UserSignUp {UserId = userId, Name = user.Name});
            _logger.LogDebug($"Created new user, UserId: {userId}");
        }

        public async Task<OAuthToken> SignIn(SignInRequest request, ConnectionInfo connectionInfo)
        {
            if (string.IsNullOrWhiteSpace(request.Email)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(request.Password)) throw new ArgumentException();

            var user = await _userRepository.FindByEmail(request.Email)!;
            if (user == null)
            {
                _logger.LogError($"User with email {request.Email} does not exists");
                throw new EmailDoesNotExistsException(request.Email);
            }

            if (!_passwordService.IsPasswordOfHash(user.PasswordHash, request.Password))
            {
                _logger.LogError($"Password does not match with email: {request.Email}");
                throw new PasswordDoesNotMatchException(request.Email);
            }

            return await _oAuthTokenService.CreateNewRefreshToken(user.Id, connectionInfo);
        }

        public async Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info)
        {
            return await _oAuthTokenService.RefreshAccessToken(refreshToken, info);
        }
    }
}