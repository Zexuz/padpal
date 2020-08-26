using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.User;

namespace Padel.Login.GrpcControllers
{
    public class UserController :UserService.UserServiceBase
    {
        private readonly Padel.Login.Services.UserService _userService;

        public UserController(Padel.Login.Services.UserService userService)
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