using System.Linq;
using Amazon;
using Amazon.Runtime;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;
using Amazon.SQS;
using Autofac;
using Microsoft.Extensions.Configuration;

namespace Padel.Queue
{
    public class AutofacModule : Module
    {
        private readonly IConfiguration _configuration;

        public AutofacModule(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        protected override void Load(ContainerBuilder builder)
        {
            AWSConfigs.AWSRegion = _configuration["AWS:Region"];

            var auth = new BasicAWSCredentials(_configuration["AWS:AccessKey"], _configuration["AWS:SecretKey"]);

            var config = new AppConfig()
            {
                AwsQueueName = _configuration["AWS:Queue:Name"],
                AwsQueueLongPollTimeSeconds = 5,
                AwsQueueMaxRetries = 3,
                Topics = _configuration
                    .GetSection("AWS:Topics")
                    .AsEnumerable()
                    .Select(pair => pair.Value)
                    .Where(s => !string.IsNullOrWhiteSpace(s))
                    .ToArray()
            };

            builder.RegisterInstance(config).AsSelf();

            builder.RegisterInstance(new AmazonSQSClient(auth)).As<IAmazonSQS>();
            builder.RegisterInstance(new AmazonSimpleNotificationServiceClient(auth)).As<IAmazonSimpleNotificationService>();

            builder.RegisterType<AwsSubscriptionService>().As<ISubscriptionService>();
            builder.RegisterType<ConsumerService>().As<IConsumerService>().SingleInstance();
            builder.RegisterType<MessageHandler>().As<IMessageHandler>();
            builder.RegisterType<QueueService>().As<IQueueService>();
            builder.RegisterType<TopicService>().As<ITopicService>();
            builder.RegisterType<QueueCache>().As<IQueueCache>();
        }
    }
}