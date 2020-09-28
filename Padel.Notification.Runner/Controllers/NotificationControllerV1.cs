using System.Collections.Generic;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Notification.MessageProcessors;
using Padel.Proto.Notification.V1;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Runner.Controllers
{
    public class NotificationControllerV1 : Proto.Notification.V1.Notification.NotificationBase
    {
        private readonly IMongoRepository<UserNotificationSetting> _mongoRepository;

        public NotificationControllerV1(IMongoRepository<UserNotificationSetting> mongoRepository)
        {
            _mongoRepository = mongoRepository;
        }

        public override async Task<AppendFcmTokenToUserResponse> AppendFcmTokenToUser(AppendFcmTokenToUserRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();

            if (string.IsNullOrWhiteSpace(request.FcmToken))
            {
                var metadata = new Metadata {{"padpal-error", "fcm token is invalid"}};
                throw new RpcException(new Status(StatusCode.InvalidArgument, nameof(request.FcmToken)), metadata);
            }

            var repoModel = await _mongoRepository.FindOneAsync(model => model.UserId == userId);
            if (repoModel == null)
            {
                await _mongoRepository.InsertOneAsync(new UserNotificationSetting
                {
                    UserId = userId,
                    FCMTokens = new List<string> {request.FcmToken}
                });
            }
            else
            {
                repoModel.FCMTokens.Add(request.FcmToken);
                await _mongoRepository.ReplaceOneAsync(repoModel);
            }

            return new AppendFcmTokenToUserResponse();
        }
    }
}