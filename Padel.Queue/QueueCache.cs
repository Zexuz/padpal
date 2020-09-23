
using System;
using System.Collections.Concurrent;
using System.Threading.Tasks;
using Amazon.SQS;
using Amazon.SQS.Model;

namespace Padel.Queue
{
    public class QueueCache : IQueueCache
    {
        private readonly ConcurrentDictionary<string, string> _queueUrlCache;
        private readonly IAmazonSQS                           _sqsClient;

        public QueueCache(IAmazonSQS sqsClient)
        {
            _sqsClient = sqsClient;
            _queueUrlCache = new ConcurrentDictionary<string, string>();
        }

        public async Task<string> GetQueueUrl(string queueName)
        {
            if (string.IsNullOrEmpty(queueName))
            {
                throw new ArgumentException("Queue name should not be blank.");
            }

            if (_queueUrlCache.TryGetValue(queueName, out var result))
            {
                return result;
            }

            try
            {
                var response = await _sqsClient.GetQueueUrlAsync(queueName);
                return _queueUrlCache.AddOrUpdate(queueName, response.QueueUrl, (q, url) => url);
            }
            catch (QueueDoesNotExistException ex)
            {
                throw new InvalidOperationException(
                    $"Could not retrieve the URL for the queue '{queueName}' as it does not exist or you do not have access to it.", ex);
            }
        }
    }
}