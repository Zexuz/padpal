using Autofac;
using FirebaseAdmin;
using Microsoft.Extensions.Configuration;
using Padel.Chat.Factories;
using Padel.Chat.Repositories;
using Padel.Chat.Repositories.MongoDb;
using Padel.Chat.Services;
using Padel.Chat.Services.Impl;
using Padel.Chat.Services.Interface;

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
            builder.RegisterInstance(new MongoDbSettings
            {
                ConnectionString = _configuration["Connections:MongoDb:padel:url"],
                DatabaseName = _configuration["Connections:MongoDb:padel:database"]
            }).As<IMongoDbSettings>();
            builder.RegisterGeneric(typeof(MongoRepository<>)).As(typeof(IMongoRepository<>));
            builder.RegisterInstance(FirebaseApp.DefaultInstance ?? FirebaseApp.Create()).AsSelf().SingleInstance();

            builder.RegisterType<ConversationService>().As<IConversationService>();
            builder.RegisterType<MessageFactory>().As<IMessageFactory>();
            builder.RegisterType<RoomFactory>().As<IRoomFactory>();
            builder.RegisterType<RoomService>().As<IRoomService>();
            builder.RegisterType<RoomIdGeneratorService>().As<IRoomIdGeneratorService>();
            builder.RegisterType<RoomRepository>().As<IRoomRepository>();
            builder.RegisterType<MessageSenderService>().As<IMessageSenderService>();
        }
    }
}