﻿using Autofac;
using Grpc.HealthCheck;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Padel.Identity.Runner.Controllers;
using Padel.Identity.Runner.HealthCheck;

namespace Padel.Identity.Runner
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
        }

        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddGrpc();
            
            services.AddHealthChecks();
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
                endpoints.MapGrpcService<AuthControllerV1>();
                endpoints.MapGrpcService<UserControllerV1>();
            });

            new Main(_configuration.GetSection("Connections:Sql:padel").Value).Migrate();
        }
    }
}