using Autofac;
using Microsoft.Extensions.Configuration;

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
        }
    }
}