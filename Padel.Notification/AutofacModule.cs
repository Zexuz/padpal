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
            builder.RegisterGeneric(typeof(MongoRepository<>)).As(typeof(IMongoRepository<>));
            builder.RegisterType<ChatMessageReceivedProcessor>().As<IMessageProcessor>();
            builder.RegisterInstance(FirebaseApp.DefaultInstance ?? FirebaseApp.Create()).AsSelf().SingleInstance();
        }
    }
}