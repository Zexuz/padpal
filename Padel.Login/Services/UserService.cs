using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.User;
using User = Padel.Proto.User.User;

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

        public async Task RegisterNewUser(User user)
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

            var userId = await _userRepository.Insert(new Repositories.User.User
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
    }
}