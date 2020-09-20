using Autofac;
using FirebaseAdmin;
using Microsoft.Extensions.Configuration;

namespace Padel.Chat.old
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
        }
    }
}