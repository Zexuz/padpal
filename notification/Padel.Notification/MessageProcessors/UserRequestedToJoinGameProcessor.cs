using System;
using System.Threading.Tasks;
using Amazon.SQS.Model;
using Padel.Notification.Extensions;
using Padel.Notification.Service;
using Padel.Proto.Game.V1;
using Padel.Proto.Notification.V1;
using Padel.Queue;

namespace Padel.Notification.MessageProcessors
{
    public class UserRequestedToJoinGameProcessor : IMessageProcessor
    {
        private readonly INotificationService _notificationService;

        public string EventName => UserRequestedToJoinGame.Descriptor.GetMessageName();

        public UserRequestedToJoinGameProcessor(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var parsed = UserRequestedToJoinGame.Parser.ParseJson(message.Body);
            var userIds = new[] {parsed.Game.Creator.UserId};

            var pushNotification = new PushNotification
            {
                UtcTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds(),
                RequestedToJoinGame = new PushNotification.Types.RequestedToJoinGame
                {
                    User = parsed.User,
                    GameId = parsed.Game.Id
                }
            };

            await _notificationService.AddAndSendNotification(userIds, pushNotification);
        }
    }
}