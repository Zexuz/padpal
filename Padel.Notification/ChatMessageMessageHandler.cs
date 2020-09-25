using System.Threading.Tasks;
using Amazon.SQS.Model;
using Microsoft.Extensions.Logging;
using Padel.Queue;

namespace Padel.Notification
{
    public class ChatMessageMessageHandler : IMessageProcessor
    {
        private readonly ILogger<ChatMessageMessageHandler> _logger;
        public           string                             EventName => "ChatMessage";

        public ChatMessageMessageHandler(ILogger<ChatMessageMessageHandler> logger)
        {
            _logger = logger;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public Task ProcessAsync(Message message)
        {
            _logger.LogInformation($"Message: {EventName}, body: {message.Body}");
            return Task.CompletedTask;
        }
    }
}