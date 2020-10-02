using Autofac;
using Microsoft.Extensions.Configuration;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Factories;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Social.Services.Interface;

namespace Padel.Social
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

            builder.RegisterType<MessageFactory>().As<IMessageFactory>();
            builder.RegisterType<RoomFactory>().As<IRoomFactory>();
            builder.RegisterType<RoomService>().As<IRoomService>();
            builder.RegisterType<RoomIdGeneratorService>().As<IRoomIdGeneratorService>();
            builder.RegisterType<RoomRepository>().As<IRoomRepository>();
            builder.RegisterType<MessageSenderService>().As<IMessageSenderService>();
        }
    }
}