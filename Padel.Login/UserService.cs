using System.Threading.Tasks;

namespace Padel.Login.Test
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

            _userRepository.Insert(user);
        }
    }
}