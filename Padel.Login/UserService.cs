using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.User;

namespace Padel.Login
{
    public class UserService: User.UserBase
    {
        public override Task<RegisterResponse> Register(RegisterRequest request, ServerCallContext context)
        {
            return Task.FromResult(new RegisterResponse());
        }
    }
}