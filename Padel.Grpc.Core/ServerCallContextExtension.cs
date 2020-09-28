using System.Linq;
using System.Net;
using Grpc.Core;

namespace Padel.Grpc.Core
{
    public static class ServerCallContextExtension
    {
        public static int GetUserId(this ServerCallContext context)
        {
            var userIdStr = context.RequestHeaders.FirstOrDefault(entry => entry.Key == Constants.UserIdHeaderKey)?.Value;
            if (string.IsNullOrWhiteSpace(userIdStr))
            {
                var metadata = new Metadata {{Constants.ErrorHeaderKey, $"missing header '{Constants.UserIdHeaderKey}'"}};
                throw new RpcException(new Status(StatusCode.Unauthenticated, ""), metadata);
            }

            return int.Parse(userIdStr);
        }
        
        public static IPAddress GetIPv4(this ServerCallContext context)
        {
            return context.GetHttpContext().Connection.RemoteIpAddress;
        }
    }
}