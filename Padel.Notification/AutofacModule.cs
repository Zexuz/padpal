using Autofac;
using FirebaseAdmin;
using Microsoft.Extensions.Configuration;
using Padel.Notification.MessageProcessors;
using Padel.Queue;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification
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
            builder.RegisterInstance(new MongoDbSettings
            {
                ConnectionString = _configuration["Connections:MongoDb:padel:url"],
                DatabaseName = _configuration["Connections:MongoDb:padel:database"]
            }).As<IMongoDbSettings>();
            builder.RegisterGeneric(typeof(MongoRepository<>)).As(typeof(IMongoRepository<>));
            builder.RegisterType<ChatMessageReceivedProcessor>().As<IMessageProcessor>();
            builder.RegisterType<FirebaseCloudMessagingWrapper>().As<IFirebaseCloudMessaging>();
        }
    }
}