using System;
using System.Linq;
using System.Threading.Tasks;
using Padel.Notification.Extensions;
using Padel.Notification.Service;
using Padel.Proto.Notification.V1;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.MessageProcessors
{
    public class FriendRequestAcceptedProcessor : IMessageProcessor
    {
        private readonly INotificationService _notificationService;

        public FriendRequestAcceptedProcessor(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        public string EventName => FriendRequestAccepted.Descriptor.GetMessageName();

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var parsed = FriendRequestAccepted.Parser.ParseJson(message.Body);
            var userIds = new[] {parsed.UserThatRequested};

            var pushNotification = new PushNotification
            {
                UtcTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds(),
                FriendRequestAccepted = new PushNotification.Types.FriendRequestAccepted
                {
                    Player = parsed.UserThatAccepted,
                },
            };

            await _notificationService.AddAndSendNotification(userIds, pushNotification);
        }
    }
}