using Amazon;
using Amazon.Runtime;
using Amazon.S3;
using Autofac;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Padel.Queue;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Factories;
using Padel.Social.MessageProcessors;
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
            AWSConfigs.AWSRegion = _configuration["AWS:Region"];

            var auth = new BasicAWSCredentials(_configuration["AWS:AccessKey"], _configuration["AWS:SecretKey"]);

            builder.RegisterInstance(new AmazonS3Client(auth)).As<IAmazonS3>();

            builder.RegisterInstance(new MongoDbSettings
            {
                ConnectionString = _configuration["Connections:MongoDb:padel:url"],
                DatabaseName = _configuration["Connections:MongoDb:padel:database"]
            }).As<IMongoDbSettings>();
            builder.RegisterGeneric(typeof(MongoRepository<>)).As(typeof(IMongoRepository<>));


            builder.RegisterType<UserSignUpMessageProcessor>().As<IMessageProcessor>();
            builder.RegisterType<MessageFactory>().As<IMessageFactory>();
            builder.RegisterType<RoomFactory>().As<IRoomFactory>();
            builder.RegisterType<RoomService>().As<IRoomService>();
            builder.RegisterType<GuidGeneratorService>().As<IGuidGeneratorService>();
            builder.RegisterType<RoomRepository>().As<IRoomRepository>();
            builder.RegisterType<MessageSenderService>().As<IMessageSenderService>();
            builder.RegisterType<ProfileSearchService>().As<IProfileSearchService>();
            builder.RegisterType<FriendRequestService>().As<IFriendRequestService>();
            builder.RegisterType<ProfileRepository>().As<IProfileRepository>();
            builder.RegisterType<GameRepository>().As<IGameRepository>();
            builder.RegisterType<CreateGameService>().As<ICreateGameService>();
            builder.RegisterType<FindGameService>().As<IFindGameService>();
            builder.RegisterType<AwsProfilePictureService>().As<IProfilePictureService>();
            builder.RegisterType<JoinGameService>().As<IJoinGameService>();
            builder.RegisterType<PublicGameInfoBuilder>().As<IPublicGameInfoBuilder>();
            builder.RegisterType<VerifyRoomAccessService>().As<IVerifyRoomAccessService>();
            builder.RegisterType<RoomEventHandler>().As<IRoomEventHandler>().As<IHostedService>().SingleInstance();
        }
    }
}