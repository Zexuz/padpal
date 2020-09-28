using Autofac;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Padel.Chat.Runner.Controllers;
using Padel.Chat.Runner.Extensions;
using Padel.Proto.Chat.V1;
using Padel.Queue;

namespace Padel.Chat.Runner
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
        }


        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints => { endpoints.MapGrpcService<ChatControllerV1>(); });

            var container = app.ApplicationServices.GetAutofacRoot();
            var publisher = container.Resolve<IPublisher>();

            var messageType = ChatMessageReceived.Descriptor.GetMessageName();
            publisher.RegisterEvent(messageType, typeof(ChatMessageReceived)).Wait();
        }
    }
}