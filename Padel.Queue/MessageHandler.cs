using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using Amazon.SQS.Model;
using Microsoft.Extensions.Logging;

namespace Padel.Queue
{
    public class MessageHandler : IMessageHandler
    {
        private readonly IQueueService                  _queueService;
        private readonly IEnumerable<IMessageProcessor> _messageProcessors;
        private readonly ILogger<ConsumerService>       _logger;

        public MessageHandler(IQueueService queueService, IEnumerable<IMessageProcessor> messageProcessors, ILogger<ConsumerService> logger)
        {
            _queueService = queueService;
            _messageProcessors = messageProcessors;
            _logger = logger;
        }

        public async Task ProcessAsync(Message message)
        {
            try
            {
                var messageType = message.MessageAttributes.GetMessageTypeAttributeValue();
                if (messageType == null)
                {
                    throw new Exception($"No 'MessageType' attribute present in message {JsonSerializer.Serialize(message)}");
                }

                var processor = _messageProcessors.SingleOrDefault(x => x.CanProcess(messageType));
                if (processor == null)
                {
                    throw new Exception($"No processor found for message type '{messageType}'");
                }

                await processor.ProcessAsync(message);
                await _queueService.DeleteMessageAsync(message.ReceiptHandle);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex,
                    $"Cannot process message [id: {message.MessageId}, receiptHandle: {message.ReceiptHandle}, body: {message.Body}] from queue {_queueService.GetQueueName()}");
            }
        }
    }
}