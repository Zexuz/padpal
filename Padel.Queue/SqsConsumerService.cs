using System;
using System.Threading;
using System.Threading.Tasks;

namespace Padel.Queue
{
    public class SqsConsumerService : ISqsConsumerService
    {
        private readonly IQueueService   _queueService;
        private readonly IMessageHandler _messageProcessors;

        private CancellationTokenSource _tokenSource;

        public SqsConsumerService(IQueueService queueService, IMessageHandler messageProcessors)
        {
            _queueService = queueService;
            _messageProcessors = messageProcessors;
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
                    messages.ForEach(async x => await _messageProcessors.ProcessAsync(x));
                }
            }
            catch (OperationCanceledException)
            {
                //operation has been canceled but it shouldn't be propagated
            }
        }
    }
}