using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.User;
using Padel.Login.Services.JsonWebToken;
using Padel.Proto.User.V1;
using OAuthToken = Padel.Login.Services.JsonWebToken.OAuthToken;
using User = Padel.Login.Repositories.User.User;

namespace Padel.Login.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository      _userRepository;
        private readonly IPasswordService     _passwordService;
        private readonly ILogger<UserService> _logger;
        private readonly IOAuthTokenService   _oAuthTokenService;

        public UserService(
            IUserRepository userRepository,
            IPasswordService passwordService,
            ILogger<UserService> logger,
            IOAuthTokenService oAuthTokenService
        )
        {
            _userRepository = userRepository;
            _passwordService = passwordService;
            _logger = logger;
            _oAuthTokenService = oAuthTokenService;
        }

        public async Task RegisterNewUser(NewUser user)
        {
            var resultByEmail = await _userRepository.FindByEmail(user.Email)!;
            if (resultByEmail != null)
            {
                _logger.LogError($"User with email {user.Email} already exists");
                throw new EmailIsAlreadyTakenException(user.Email);
            }

            var resultByUsername = await _userRepository.FindByUsername(user.Username)!;
            if (resultByUsername != null)
            {
                _logger.LogError($"User with username {user.Username} already exists");
                throw new UsernameIsAlreadyTakenException(user.Username);
            }

            var hashedPassword = _passwordService.GenerateHashFromPlanText(user.Password);
            var dateOfBirth = DateTime.Parse($"{user.DateOfBirth.Year}-{user.DateOfBirth.Month}-{user.DateOfBirth.Day}");

            var userId = await _userRepository.Insert(new User
            {
                Username = user.Username,
                Email = user.Email,
                PasswordHash = hashedPassword,
                FirstName = user.FirstName,
                LastName = user.LastName,
                DateOfBirth = dateOfBirth,
                Created = DateTimeOffset.UtcNow
            });
            _logger.LogDebug($"Created new user, UserId: {userId}");
        }

        public async Task<OAuthToken> Login(LoginRequest request, ConnectionInfo connectionInfo)
        {
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

            return await _oAuthTokenService.CreateNewRefreshToken(user, connectionInfo);
        }
    }
}