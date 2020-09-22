using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Amazon.SQS.Model;
using Microsoft.Extensions.Logging;

namespace Padel.Queue
{
    public class SqsConsumerService : ISqsConsumerService
    {
        private readonly IQueueService                     _queueService;
        private readonly IEnumerable<IMessageProcessor> _messageProcessors;
        private readonly ILogger<SqsConsumerService>    _logger;

        private CancellationTokenSource _tokenSource;

        public SqsConsumerService(IQueueService queueService, IEnumerable<IMessageProcessor> messageProcessors, ILogger<SqsConsumerService> logger)
        {
            _queueService = queueService;
            _messageProcessors = messageProcessors;
            _logger = logger;
        }

        public void StartConsuming()
        {
            if (!IsConsuming())
            {
                _tokenSource = new CancellationTokenSource();
                ProcessAsync();
            }
        }

        public void StopConsuming()
        {
            if (IsConsuming())
            {
                _tokenSource.Cancel();
            }
        }

        public async Task ReprocessMessagesAsync()
        {
            await _queueService.RestoreFromDeadLetterQueueAsync();
        }

        private bool IsConsuming()
        {
            return _tokenSource != null && !_tokenSource.Token.IsCancellationRequested;
        }

        private async void ProcessAsync()
        {
            try
            {
                while (!_tokenSource.Token.IsCancellationRequested)
                {
                    var messages = await _queueService.GetMessagesAsync(_tokenSource.Token);
                    messages.ForEach(async x => await ProcessMessageAsync(x));
                }
            }
            catch (OperationCanceledException)
            {
                //operation has been canceled but it shouldn't be propagated
            }
        }

        private async Task ProcessMessageAsync(Message message)
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