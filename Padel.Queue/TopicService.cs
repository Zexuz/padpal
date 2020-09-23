using System;
using System.Net;
using System.Threading.Tasks;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;

namespace Padel.Queue
{
    public class TopicService : ITopicService
    {
        private readonly IAmazonSimpleNotificationService _snsClient;

        public TopicService(IAmazonSimpleNotificationService snsClient)
        {
            _snsClient = snsClient;
        }

        public async Task<Topic> FindTopic(string name)
        {
            return await _snsClient.FindTopicAsync(name);
        }

        public async Task<Topic> FindOrCreateTopic(string name)
        {
            var topic = await FindTopic(name);
            if (topic != null) return topic;

            var createTopicResponse = await _snsClient.CreateTopicAsync(name);
            if (createTopicResponse.HttpStatusCode != HttpStatusCode.OK)
            {
                throw new Exception("");
            }

            return new Topic {TopicArn = createTopicResponse.TopicArn};
        }
    }
}