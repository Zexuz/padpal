using System.Security.Claims;
using Grpc.Core;

namespace Padel.Runner.Extensions
{
    public static class ServerCallContextExtension
    {
        public static int GetUserId(this ServerCallContext context)
        {
            var httpContext = context.GetHttpContext();
            return int.Parse(httpContext.User.FindFirstValue(ClaimTypes.NameIdentifier));
        }
    }
}