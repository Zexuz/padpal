using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Padel.Test.Core
{
    public class WebApplicationFactoryBase<TStartup> : AutofacWebApplicationFactory<TStartup> where TStartup : class
    {
        public readonly string DbTestPrefix = "padpal_test_";
        public       string RandomSuffix { get; set; }

        protected WebApplicationFactoryBase()
        {
            RandomSuffix = StringGenerator.RandomString(15);
        }

        protected override IHostBuilder CreateHostBuilder()
        {
            return base.CreateHostBuilder().ConfigureServices(services => { services.AddSingleton<IStartupFilter, CustomStartupFilter>(); });
        }
    }
}