using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Padel.Test.Core
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