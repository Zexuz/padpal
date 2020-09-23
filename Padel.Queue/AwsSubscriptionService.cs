using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;
using Amazon.SQS;
using Amazon.SQS.Model;
using Microsoft.Extensions.Logging;

namespace Padel.Queue
{
    public class AwsSubscriptionService : ISubscriptionService
    {
        private readonly AppConfig                        _appConfig;
        private readonly IAmazonSQS                       _sqsClient;
        private readonly IAmazonSimpleNotificationService _snsClient;
        private readonly ITopicService                    _topicService;
        private readonly ILogger<AwsSubscriptionService>  _logger;

        public AwsSubscriptionService
        (
            AppConfig                        appConfig,
            IAmazonSQS                       sqsClient,
            IAmazonSimpleNotificationService snsClient,
            ITopicService                    topicService,
            ILogger<AwsSubscriptionService>  logger
        )
        {
            _appConfig = appConfig;
            _sqsClient = sqsClient;
            _snsClient = snsClient;
            _topicService = topicService;
            _logger = logger;
        }

        public async Task CreateQueueAndSubscribeToTopic()
        {
            const int maxRetries = 3;
            var delayTime = TimeSpan.FromSeconds(1);

            try
            {
                var listQueuesResponse = await _sqsClient.ListQueuesAsync(_appConfig.AwsQueueName);
                if (listQueuesResponse.HttpStatusCode != HttpStatusCode.OK)
                {
                    throw new Exception($"ListQueuesAsync returns none OK status code {listQueuesResponse.HttpStatusCode}");
                }

                var queueUrl = listQueuesResponse.QueueUrls.FirstOrDefault();
                if (listQueuesResponse.QueueUrls.Count == 0)
                {
                    queueUrl = await CreateQueueAndDeadLetterQueue();
                }

                foreach (var topicName in _appConfig.Topics)
                {
                    int currentTry = 0;
                    Topic topic;
                    while ((topic = await _topicService.FindTopic(topicName)) == null)
                    {
                        if (currentTry++ == 3)
                        {
                            _logger.LogCritical($"Could not find topic with name {topicName}, max retries reached");
                            throw new Exception($"Could not find topic with name {topicName}, max retries reached");
                        }

                        _logger.LogWarning(
                            $"Could not find topic with name {topicName}, no: {currentTry}/{maxRetries}, retrying again in: {delayTime.ToString()}");
                        await Task.Delay(delayTime);
                    }

                    var arn = await _snsClient.SubscribeQueueAsync(topic.TopicArn, _sqsClient, queueUrl);
                    await _snsClient.SetSubscriptionAttributesAsync(new SetSubscriptionAttributesRequest
                    {
                        AttributeName = "RawMessageDelivery",
                        AttributeValue = "true",
                        SubscriptionArn = arn,
                    });
                }
            }
            catch (Exception e)
            {
                _logger.LogError(e, $"Error when creating SQS queue {_appConfig.AwsQueueName} and/or {_appConfig.AwsDeadLetterQueueName} queue");
                throw;
            }
        }

        private async Task<string> CreateQueueAndDeadLetterQueue()
        {
            var queueResponse = await _sqsClient.CreateQueueAsync(_appConfig.AwsQueueName);
            if (queueResponse.HttpStatusCode != HttpStatusCode.OK)
            {
                throw new Exception($"CreateQueueAsync returns none OK status code {queueResponse.HttpStatusCode}");
            }

            var dlcQueueResponse = await _sqsClient.CreateQueueAsync(_appConfig.AwsDeadLetterQueueName);
            if (dlcQueueResponse.HttpStatusCode != HttpStatusCode.OK)
            {
                throw new Exception($"CreateQueueAsync (dlc) returns none OK status code {dlcQueueResponse.HttpStatusCode}");
            }

            var deadLetterQueueArn = await GetDeadLetterQueueArn(dlcQueueResponse);
            var reDrivePolicy = new
            {
                maxReceiveCount = _appConfig.AwsQueueMaxRetries.ToString(),
                deadLetterTargetArn = deadLetterQueueArn
            };
            await _sqsClient.SetQueueAttributesAsync(new SetQueueAttributesRequest
            {
                QueueUrl = queueResponse.QueueUrl,
                Attributes = new Dictionary<string, string>
                {
                    {"RedrivePolicy", JsonSerializer.Serialize(reDrivePolicy)},
                    // Enable Long polling
                    {"ReceiveMessageWaitTimeSeconds", _appConfig.AwsQueueLongPollTimeSeconds.ToString()}
                }
            });
            return queueResponse.QueueUrl;
        }

        private async Task<string> GetDeadLetterQueueArn(CreateQueueResponse dlcQueueResponse)
        {
            const string arnAttribute = "QueueArn";

            var attributes = await _sqsClient.GetQueueAttributesAsync(new GetQueueAttributesRequest
            {
                QueueUrl = dlcQueueResponse.QueueUrl,
                AttributeNames = new List<string> {arnAttribute}
            });
            var deadLetterQueueArn = attributes.Attributes[arnAttribute];
            return deadLetterQueueArn;
        }
    }
}