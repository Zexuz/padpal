using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.User;

namespace Padel.Login
{
    public class GrpcUserService: Proto.User.UserService.UserServiceBase
    {
        public override Task<RegisterResponse> Register(RegisterRequest request, ServerCallContext context)
        {
            return Task.FromResult(new RegisterResponse());
        }
    }
}