using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.User;

namespace Padel.Login.GrpcControllers
{
    public class UserController :UserService.UserServiceBase
    {
        private readonly Services.IUserService _userService;

        public UserController(Services.IUserService userService)
        {
            _userService = userService;
        }

        public override async Task<RegisterResponse> Register(RegisterRequest request, ServerCallContext context)
        {
            await _userService.RegisterNewUser(request.User);
            return new RegisterResponse();
        }
    }
}