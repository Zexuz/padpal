using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Padel.Test.Core;

namespace Padel.Runner.Test.IntegrationTests.Helpers
{
    public class WebApplicationFactoryBase<TStartup> : WebApplicationFactory<TStartup> where TStartup : class
    {
        protected const string DbTestPrefix = "padpal_test_";
        protected       string RandomSuffix { get; set; }

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