using System;
using System.Threading.Tasks;
using Padel.Notification.Extensions;
using Padel.Notification.Service;
using Padel.Proto.Game.V1;
using Padel.Proto.Notification.V1;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.MessageProcessors
{
    public class GameCreatedProcessor : IMessageProcessor
    {
        private readonly INotificationService _notificationService;

        public string EventName => GameCreated.Descriptor.GetMessageName();

        public GameCreatedProcessor(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var parsed = GameCreated.Parser.ParseJson(message.Body);
            var userIds = parsed.InvitedPlayers;

            var pushNotification = new PushNotification
            {
                UtcTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds(),
                InvitedToGame = new PushNotification.Types.InvitedToGame
                {
                    Name = parsed.Creator,
                    Place = parsed.PublicGameInfo.Location.Name,
                    UnixTime = parsed.PublicGameInfo.StartTime,
                    DurationInMinutes = parsed.PublicGameInfo.DurationInMinutes,
                }
            };

            await _notificationService.AddAndSendNotification(userIds, pushNotification);
        }
    }
}