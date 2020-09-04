using System;
using System.Linq;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Padel.Proto.User.V1;

namespace Padel.Runner.Controllers
{
    // TODO Rename this conteoller to MeController, b/c this is where we fetch data about the current user?
    // THere will be another UserController where we can fetch data about other users
    [Authorize]
    public class UserControllerV1 : UserService.UserServiceBase
    {
        [Authorize]
        public override Task<MeResponse> Me(MeRequest request, ServerCallContext context)
        {
            var httpContext = context.GetHttpContext();
            var user = httpContext.User;
            var claims = user.Claims.ToList();
            Console.WriteLine(httpContext.User);
            Console.WriteLine(context.AuthContext.PeerIdentityPropertyName);
            return Task.FromResult(new MeResponse
            {
                Me = new Me
                {
                    Email = "someEmail@asdc.,com",
                    Username = "use4rname",
                    FirstName = "FIrasr",
                    LastName = "lasrt"
                }
            });
        }
    }
}