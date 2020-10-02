using System.Collections.Generic;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.Extensions.Logging;
using Padel.Grpc.Core;
using Padel.Proto.Notification.V1;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Runner.Controllers
{
    public class NotificationControllerV1 : Proto.Notification.V1.Notification.NotificationBase
    {
        private readonly IMongoRepository<UserNotificationSetting> _mongoRepository;
        private readonly ILogger<NotificationControllerV1>         _logger;

        public NotificationControllerV1(IMongoRepository<UserNotificationSetting> mongoRepository, ILogger<NotificationControllerV1> logger)
        {
            _mongoRepository = mongoRepository;
            _logger = logger;
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
                if (!repoModel.FCMTokens.Contains(request.FcmToken))
                {
                    repoModel.FCMTokens.Add(request.FcmToken);
                    await _mongoRepository.ReplaceOneAsync(repoModel);
                }
                else
                {
                    _logger.LogDebug($"Fmc token already exists {request.FcmToken}");
                }
            }

            return new AppendFcmTokenToUserResponse();
        }
    }
}