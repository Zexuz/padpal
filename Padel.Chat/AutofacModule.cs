using Autofac;
using FirebaseAdmin;
using Microsoft.Extensions.Configuration;
using Padel.Chat.old;

namespace Padel.Chat
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
            builder.Register(c => new MongoDbConnectionFactory("mongodb://localhost:27017", "padpal")).As<IMongoDbConnectionFactory>();
            builder.RegisterGeneric(typeof(MongoRepository<,>)).As(typeof(IRepository<,>));
            builder.RegisterInstance(FirebaseApp.Create()).AsSelf().SingleInstance();
            
            builder.RegisterType<ConversationService>().As<IConversationService>();
            builder.RegisterType<MessageFactory>().As<IMessageFactory>();
            builder.RegisterType<RoomFactory>().As<IRoomFactory>();
            builder.RegisterType<RoomService>().As<IRoomService>();
            builder.RegisterType<RoomIdGenerator>().As<IRoomIdGenerator>();
            builder.RegisterType<RoomRepository>().As<IRoomRepository>();
        }
    }
}