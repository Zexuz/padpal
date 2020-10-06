using System;
using System.Threading.Tasks;
using Padel.Notification.Extensions;
using Padel.Notification.Service;
using Padel.Proto.Notification.V1;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.MessageProcessors
{
    public class ChatMessageReceivedProcessor : IMessageProcessor
    {
        private readonly INotificationService _notificationService;

        public string EventName => ChatMessageReceived.Descriptor.GetMessageName();

        public ChatMessageReceivedProcessor(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var parsed = ChatMessageReceived.Parser.ParseJson(message.Body);
            var userIds = parsed.Participants;

            var pushNotification = new PushNotification
            {
                UtcTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds(),
                ChatMessageReceived = new PushNotification.Types.ChatMessageReceived
                {
                    RoomId = parsed.RoomId
                }
            };

            await _notificationService.AddAndSendNotification(userIds, pushNotification);
        }
    }
}