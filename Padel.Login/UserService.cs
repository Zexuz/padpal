using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.User;

namespace Padel.Login
{
    public class UserService: Proto.User.UserService.UserServiceBase
    {
        public override Task<RegisterResponse> Register(RegisterRequest request, ServerCallContext context)
        {
            return Task.FromResult(new RegisterResponse());
        }
    }
}