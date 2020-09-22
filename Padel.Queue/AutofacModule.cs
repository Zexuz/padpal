using Amazon;
using Amazon.Runtime;
using Amazon.SimpleNotificationService;
using Amazon.SQS;
using Autofac;
using Microsoft.Extensions.Configuration;

namespace Padel.Queue
{
    // There should be no AutoFac module in the class lib
    public class AutofacModule : Module
    {
        private readonly IConfiguration _configuration;

        public AutofacModule(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        protected override void Load(ContainerBuilder builder)
        {
            // AWSConfigs.AWSRegion = "eu-north-1";
            AWSConfigs.AWSRegion = _configuration["AWS:Region"];

            var auth = new BasicAWSCredentials(_configuration["AWS:AccessKey"], _configuration["AWS:SecretKey"]);

            builder.RegisterInstance(new AmazonSQSClient(auth)).AsSelf().SingleInstance();
            builder.RegisterInstance(new AmazonSimpleNotificationServiceClient(auth)).AsSelf().SingleInstance();

            builder.RegisterType<AwsSubscriptionService>().As<ISubscriptionService>();
        }
    }
}