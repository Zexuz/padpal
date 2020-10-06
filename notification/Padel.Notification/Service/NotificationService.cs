using System.Collections.Generic;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;
using Microsoft.Extensions.Logging;
using Padel.Notification.MessageProcessors;
using Padel.Notification.Repository;
using Padel.Proto.Notification.V1;

namespace Padel.Notification.Service
{
    public class NotificationService : INotificationService
    {
        private readonly IFirebaseCloudMessaging               _firebaseCloudMessaging;
        private readonly IUserRepository                       _userRepository;
        private readonly ILogger<ChatMessageReceivedProcessor> _logger;

        public NotificationService
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

        public async Task AddAndSendNotification(IEnumerable<int> userIds, PushNotification pushNotification)
        {
            var tokens = new List<string>();

            foreach (var userId in userIds)
            {
                var res = await _userRepository.FindOrCreateByUserId(userId);
                res.Notifications.Add(pushNotification);
                await _userRepository.ReplaceOneAsync(res);

                // TODO Check if the user wants to be notified 
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