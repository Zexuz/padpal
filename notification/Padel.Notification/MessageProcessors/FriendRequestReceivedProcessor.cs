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
    public class FriendRequestReceivedProcessor : IMessageProcessor
    {
        private readonly INotificationService _notificationService;

        public string EventName => FriendRequestReceived.Descriptor.GetMessageName();

        public FriendRequestReceivedProcessor(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }


        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var parsed = FriendRequestReceived.Parser.ParseJson(message.Body);
            var userIds = new[] {parsed.ToUser};

            var pushNotification = new PushNotification
            {
                UtcTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds(),
                FriendRequestReceived = new PushNotification.Types.FriendRequestReceived()
                {
                    Player = parsed.FromUser,
                },
            };

            await _notificationService.AddAndSendNotification(userIds, pushNotification);
        }
    }
}