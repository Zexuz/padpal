using System;
using Autofac;
using Microsoft.Extensions.Configuration;
using Padel.Identity.Repositories;
using Padel.Identity.Repositories.Device;
using Padel.Identity.Repositories.User;
using Padel.Identity.Services;
using Padel.Identity.Services.JsonWebToken;

namespace Padel.Identity
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
            builder.RegisterType<UserRepository>().As<IUserRepository>();
            builder.RegisterType<DeviceRepository>().As<IDeviceRepository>();
            builder.RegisterType<AuthService>().As<IAuthService>();
            builder.RegisterType<PasswordService>().As<IPasswordService>();
            builder.RegisterType<DatabaseConnectionFactory>().As<IDatabaseConnectionFactory>();
            builder.RegisterType<KeyLoader>().As<IKeyLoader>();
            builder.RegisterType<FileService>().As<IFileService>();
            builder.RegisterType<JsonWebTokenBuilder>().As<IJsonWebTokenBuilder>();
            builder.RegisterType<JsonWebTokenService>().As<IJsonWebTokenService>();
            builder.RegisterType<OAuthTokenService>().As<IOAuthTokenService>();
            builder.RegisterType<CustomRandom>().As<IRandom>();

            builder.RegisterInstance(new JsonWebTokenServiceOptions {LifeSpan = TimeSpan.FromMinutes(30)}).AsSelf();
        }
    }
}