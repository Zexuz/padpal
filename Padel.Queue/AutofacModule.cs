using Amazon;
using Amazon.Runtime;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;
using Amazon.SQS;
using Autofac;
using Microsoft.Extensions.Configuration;
using Padel.Queue.Interface;

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

            builder.RegisterInstance(new AmazonSQSClient(auth)).As<IAmazonService>();
            builder.RegisterInstance(new AmazonSimpleNotificationServiceClient(auth)).As<ISimpleNotificationServicePaginatorFactory>();

            builder.RegisterType<AwsSubscriptionService>().As<ISubscriptionService>();
            builder.RegisterType<ConsumerService>().As<IConsumerService>().SingleInstance();
            builder.RegisterType<MessageHandler>().As<IMessageHandler>();
            builder.RegisterType<QueueService>().As<IQueueService>();
            builder.RegisterType<TopicService>().As<ITopicService>();
            builder.RegisterType<QueueCache>().As<IQueueCache>();
        }
    }
}