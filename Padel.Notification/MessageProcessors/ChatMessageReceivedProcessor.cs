using System.Collections.Generic;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;
using Microsoft.Extensions.Logging;
using Padel.Notification.Extensions;
using Padel.Proto.Chat.V1;
using Padel.Queue;
using Padel.Repository.Core.MongoDb;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.MessageProcessors
{
    public class ChatMessageReceivedProcessor : IMessageProcessor
    {
        private readonly IFirebaseCloudMessaging                        _firebaseCloudMessaging;
        private readonly IMongoRepository<UserNotificationSetting> _mongoRepository;
        private readonly ILogger<ChatMessageReceivedProcessor>          _logger;

        public string EventName => ChatMessageReceived.Descriptor.GetMessageName();

        public ChatMessageReceivedProcessor
        (
            IFirebaseCloudMessaging                        firebaseCloudMessaging,
            IMongoRepository<UserNotificationSetting> mongoRepository,
            ILogger<ChatMessageReceivedProcessor>          logger
        )
        {
            _firebaseCloudMessaging = firebaseCloudMessaging;
            _mongoRepository = mongoRepository;
            _logger = logger;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var tokens = new List<string>();
            var parsed = ChatMessageReceived.Parser.ParseJson(message.Body);
            foreach (var userId in parsed.Participants)
            {
                var res = await _mongoRepository.FindOneAsync(model => model.UserId == userId);
                if (res == null)
                {
                    _logger.LogWarning($"We don't have a user with id '{userId}' in the collection");
                    continue;
                }

                tokens.AddRange(res.FCMTokens);
            }

            // TODO Handle case where we have 0 tokens!
            await _firebaseCloudMessaging.SendMulticastAsync(new MulticastMessage
            {
                Data = new Dictionary<string, string>
                {
                    {"type", "<TODO NOTIFICATION NAME>"},
                    {"content", "<TODO NOTIFICATION>"},
                },
                Tokens = tokens
            });
        }
    }
}