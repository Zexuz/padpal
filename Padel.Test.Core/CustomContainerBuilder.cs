using System.Collections.Generic;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;

namespace Padel.Test.Core
{
    public class CustomContainerBuilder : Autofac.ContainerBuilder
    {
        private readonly IServiceCollection services;

        public CustomContainerBuilder(IServiceCollection services)
        {
            this.services = services;
            this.Populate(services);
        }

        public Autofac.IContainer CustomBuild()
        {
            var sp = this.services.BuildServiceProvider();
#pragma warning disable CS0612 // Type or member is obsolete
            var filters = sp.GetRequiredService<IEnumerable<IStartupConfigureContainerFilter<Autofac.ContainerBuilder>>>();
#pragma warning restore CS0612 // Type or member is obsolete

            foreach (var filter in filters)
            {
                filter.ConfigureContainer(b => { })(this);
            }

            return this.Build();
        }
    }
}