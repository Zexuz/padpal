using System;
using System.Threading.Tasks;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.User;
using User = Padel.Proto.User.User;

namespace Padel.Login.Services
{
    public class UserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task RegisterNewUser(User user)
        {
            var resultByEmail = await _userRepository.FindByEmail("robin.edbom@gmail.com")!;
            if (resultByEmail != null)
            {
                throw new EmailIsAlreadyTakenException("robin.edbom@gmail.com");
            }

            var resultByUsername = await _userRepository.FindByUsername("zexuz")!;
            if (resultByUsername != null)
            {
                throw new UsernameIsAlreadyTakenException("zexuz");
            }

            // TODO change to MsSql since MySql only gives us trubles. 
            
            // TODO USE BCRYPT OR OTHER PACKAGE TO SALT AND HASH PASSWORD
            await _userRepository.Insert(new Repositories.User.User
            {
                Username = user.Username,
                Email = user.Email,
                PasswordHash = user.Password,
                FirstName = user.FirstName,
                LastName = user.LastName,
                DateOfBirth = DateTime.Parse($"{user.DateOfBirth.Year}-{user.DateOfBirth.Month}-{user.DateOfBirth.Day}"),
                Created = DateTimeOffset.UtcNow
            });
        }
    }
}