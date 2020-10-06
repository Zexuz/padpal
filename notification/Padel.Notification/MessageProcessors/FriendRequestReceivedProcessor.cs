using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;
using Microsoft.Extensions.Logging;
using Padel.Notification.Extensions;
using Padel.Notification.Models;
using Padel.Notification.Repository;
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
                    UserId = parsed.FromUser.Id,
                    Name = parsed.FromUser.Name,
                },
            };

            await _notificationService.AddAndSendNotification(userIds, pushNotification);
        }
    }
}