using System;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.Notification.V1;

namespace Padel.Notification.Runner.Controllers
{
    public class NotificationControllerV1 : Proto.Notification.V1.Notification.NotificationBase
    {
        public override Task<AppendFcmTokenToUserResponse> AppendFcmTokenToUser(AppendFcmTokenToUserRequest request, ServerCallContext context)
        {
            if (string.IsNullOrWhiteSpace(request.FcmToken))
            {
                throw new ArgumentException("is empty", nameof(request.FcmToken));
            }

            return base.AppendFcmTokenToUser(request, context);
        }
    }
}