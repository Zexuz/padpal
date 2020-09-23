using System.Net;
using System.Security.Claims;
using Grpc.Core;

namespace Padel.Identity.Runner.Extensions
{
    public static class ServerCallContextExtension
    {
        public static int GetUserId(this ServerCallContext context)
        {
            var httpContext = context.GetHttpContext();
            return int.Parse(httpContext.User.FindFirstValue(ClaimTypes.NameIdentifier));
        }

        public static IPAddress GetIPv4(this ServerCallContext context)
        {
            return context.GetHttpContext().Connection.RemoteIpAddress;
        }
    }
}