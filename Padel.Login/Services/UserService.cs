using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.User;
using Padel.Proto.User.V1;
using User = Padel.Login.Repositories.User.User;

namespace Padel.Login.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository      _userRepository;
        private readonly IPasswordService     _passwordService;
        private readonly ILogger<UserService> _logger;

        public UserService(IUserRepository userRepository, IPasswordService passwordService, ILogger<UserService> logger)
        {
            _userRepository = userRepository;
            _passwordService = passwordService;
            _logger = logger;
        }

        public async Task RegisterNewUser(Padel.Proto.User.V1.User user)
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
            _logger.LogDebug($"Created new hashedPassword: {hashedPassword}, for userId: {userId}");
        }

        public async Task Login(LoginRequest request)
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

            // TODO RETURN JWT CREDENTIALS
        }
    }
}