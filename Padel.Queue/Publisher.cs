using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;

namespace Padel.Queue
{
    public class Publisher : IPublisher
    {
        public IReadOnlyList<IRegisteredEvent> Events => _events;

        private readonly IAmazonSimpleNotificationService _snsService;
        private readonly ITopicService                    _topicService;
        private readonly List<RegisteredEvent>            _events = new List<RegisteredEvent>();

        public Publisher(IAmazonSimpleNotificationService snsService, ITopicService topicService)
        {
            _snsService = snsService;
            _topicService = topicService;
        }

        public async Task RegisterEvent(string name, Type type)
        {
            var topic = await _topicService.FindOrCreateTopic(name);

            var registeredEvent = _events.FirstOrDefault(ev => ev.Type == type);
            if (registeredEvent != null)
            {
                throw new Exception($"The type: {type}, is already registered under '{registeredEvent.Name}'");
            }

            _events.Add(new RegisteredEvent
            {
                Arn = topic,
                Name = name,
                Type = type,
            });
        }

        public async Task PublishMessage(object message)
        {
            var messageType = message.GetType();
            var registeredEvent = _events.FirstOrDefault(ev => ev.Type == messageType);
            if (registeredEvent == null)
            {
                throw new Exception($"Unknown type: {messageType}, You need to register a message before publishing it!");
            }

            await _snsService.PublishAsync(new PublishRequest
            {
                Message = JsonSerializer.Serialize(message, new JsonSerializerOptions{PropertyNamingPolicy = JsonNamingPolicy.CamelCase}),
                MessageAttributes = new Dictionary<string, MessageAttributeValue>
                {
                    {
                        "MessageType", new MessageAttributeValue
                        {
                            DataType = nameof(String),
                            StringValue = registeredEvent.Name
                        }
                    }
                },
                TopicArn = registeredEvent.Arn.TopicArn,
            });
        }
    }
}