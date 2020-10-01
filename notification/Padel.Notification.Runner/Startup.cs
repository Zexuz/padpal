using Autofac;
using Autofac.Extensions.DependencyInjection;
using Grpc.HealthCheck;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Padel.Notification.Runner.Controllers;
using Padel.Notification.Runner.HealthCheck;
using Padel.Queue;

namespace Padel.Notification.Runner
{
    public class Startup
    {
        private readonly IConfiguration _configuration;

        public Startup(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public void ConfigureContainer(ContainerBuilder builder)
        {
            builder.RegisterModule(new AutofacModule(_configuration));
            builder.RegisterModule(new Padel.Queue.AutofacModule(_configuration));
        }

        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddGrpc();

            var hcBuilder = services.AddHealthChecks();
            // hcBuilder.AddCheck(
            //     "OrderingDB-check",
            //     new CustomHealthCheck(),
            //     HealthStatus.Unhealthy,
            //     new string[] {"orderingdb"});

            services.AddSingleton<HealthServiceImpl>();
            services.AddHostedService<StatusService>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapGrpcService<HealthServiceImpl>();
                endpoints.MapGrpcService<NotificationControllerV1>();
            });

            var container = app.ApplicationServices.GetAutofacRoot();
            var subscriptionService = container.Resolve<ISubscriptionService>();
            var consumerService = container.Resolve<IConsumerService>();

            subscriptionService.CreateQueueAndSubscribeToTopic().Wait();
            // consumerService.ReprocessMessagesAsync().Wait();
            consumerService.StartConsuming();
        }
    }
}