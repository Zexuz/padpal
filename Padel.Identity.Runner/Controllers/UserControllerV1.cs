using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Padel.Identity.Repositories.User;
using Padel.Identity.Runner.Extensions;
using Padel.Proto.User.V1;

namespace Padel.Identity.Runner.Controllers
{
    // TODO Rename this conteoller to MeController, b/c this is where we fetch data about the current user?
    // Lets combine Me and UserService untill we know how it will be implemented
    // THere will be another UserController where we can fetch data about other users
    [Authorize]
    public class UserControllerV1 : UserService.UserServiceBase
    {
        private readonly IUserRepository _userRepository;

        public UserControllerV1(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        [Authorize]
        public override async Task<MeResponse> Me(MeRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();
            var user = await _userRepository.Get(userId);
            return new MeResponse
            {
                Me = new Me
                {
                    Email = user.Email,
                    Username = user.Username,
                    FirstName = user.FirstName,
                    LastName = user.LastName
                }
            };
        }
    }
}