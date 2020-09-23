
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Amazon.SQS.Model;

namespace Padel.Queue
{
    public interface IQueueService
    {
        string GetQueueName();

        Task<List<Message>> GetMessagesAsync(CancellationToken cancellationToken = default);

        Task PostMessageAsync(string messageBody, string messageType);

        Task DeleteMessageAsync(string receiptHandle);

        Task RestoreFromDeadLetterQueueAsync(CancellationToken cancellationToken = default);
    }
}