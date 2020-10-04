using System.Collections.Generic;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.Extensions.Logging;
using Padel.Grpc.Core;
using Padel.Notification.Models;
using Padel.Notification.Repository;
using Padel.Proto.Notification.V1;

namespace Padel.Notification.Runner.Controllers
{
    public class NotificationControllerV1 : Proto.Notification.V1.Notification.NotificationBase
    {
        private readonly IUserRepository                   _userRepository;
        private readonly ILogger<NotificationControllerV1> _logger;

        public NotificationControllerV1(IUserRepository userRepository, ILogger<NotificationControllerV1> logger)
        {
            _userRepository = userRepository;
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

            var repoModel = await _userRepository.FindOneAsync(model => model.UserId == userId);
            if (repoModel == null)
            {
                await _userRepository.InsertOneAsync(new User
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
                    await _userRepository.ReplaceOneAsync(repoModel);
                }
                else
                {
                    _logger.LogDebug($"Fmc token already exists {request.FcmToken}");
                }
            }

            return new AppendFcmTokenToUserResponse();
        }

        public override Task<GetNotificationResponse> GetNotification(GetNotificationRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();
            var user = _userRepository.FindByUserId(userId);
            if (user == null)
            {
                return Task.FromResult(new GetNotificationResponse());
            }

            return Task.FromResult(new GetNotificationResponse
            {
                Notifications =
                {
                    user.Notifications
                }
            });
        }
    }
}