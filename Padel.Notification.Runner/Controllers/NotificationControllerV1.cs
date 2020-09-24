using System.Threading.Tasks;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Proto.Notification.V1;

namespace Padel.Notification.Runner.Controllers
{
    public class NotificationControllerV1 : Proto.Notification.V1.Notification.NotificationBase
    {
        public override Task<AppendFcmTokenToUserResponse> AppendFcmTokenToUser(AppendFcmTokenToUserRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();
            
            if (string.IsNullOrWhiteSpace(request.FcmToken))
            {
                var metadata = new Metadata {{"padpal-error", "fcm token is invalid"}};
                throw new RpcException(new Status(StatusCode.InvalidArgument, nameof(request.FcmToken)), metadata);
            }

            return base.AppendFcmTokenToUser(request, context);
        }
    }
}