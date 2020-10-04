using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;
using Microsoft.Extensions.Logging;
using Padel.Notification.Extensions;
using Padel.Notification.Models;
using Padel.Notification.Repository;
using Padel.Proto.Notification.V1;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.MessageProcessors
{
    public class ChatMessageReceivedProcessor : IMessageProcessor
    {
        private readonly IFirebaseCloudMessaging               _firebaseCloudMessaging;
        private readonly IUserRepository                       _userRepository;
        private readonly ILogger<ChatMessageReceivedProcessor> _logger;

        public string EventName => ChatMessageReceived.Descriptor.GetMessageName();

        public ChatMessageReceivedProcessor
        (
            IFirebaseCloudMessaging               firebaseCloudMessaging,
            IUserRepository                       userRepository,
            ILogger<ChatMessageReceivedProcessor> logger
        )
        {
            _firebaseCloudMessaging = firebaseCloudMessaging;
            _userRepository = userRepository;
            _logger = logger;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            // TODO This will be the same for all messages the we process in "Notification Service"
            var parsed = ChatMessageReceived.Parser.ParseJson(message.Body);
            var userIds = parsed.Participants;

            var tokens = new List<string>();

            foreach (var userId in userIds)
            {
                var pushNotification = new PushNotification
                {
                    UtcTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds(),
                    ChatMessageReceived = new PushNotification.Types.ChatMessageReceived
                    {
                        RoomId = parsed.RoomId
                    }
                };


                var res = _userRepository.FindByUserId(userId);
                if (res == null)
                {
                    await _userRepository.InsertOneAsync(new User
                    {
                        UserId = userId,
                        Notifications = new List<PushNotification>()
                        {
                            pushNotification
                        },
                    });
                    _logger.LogWarning($"We don't have a user with id '{userId}' in the collection");
                    continue;
                }

                res.Notifications.Add(pushNotification);
                await _userRepository.ReplaceOneAsync(res);

                // TODO Check if the user wan't to be notified 
                tokens.AddRange(res.FCMTokens);
            }

            // SendNotification
            if (tokens.Count == 0)
            {
                return;
            }

            await _firebaseCloudMessaging.SendMulticastAsync(new MulticastMessage
            {
                Data = new Dictionary<string, string>
                {
                    {"type", "<TODO NOTIFICATION NAME>"},
                    // The event name eg social_v1_ChatMessageReceived is NOT the same as the Notification type name bc they might not have the same data
                    {"content", "<TODO NOTIFICATION>"},
                },
                Tokens = tokens
            });
        }
    }
}