using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.User.V1;

namespace Padel.Login.GrpcControllers
{
    public class UserControllerV1 : UserService.UserServiceBase
    {
        private readonly Services.IUserService _userService;

        public UserControllerV1(Services.IUserService userService)
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