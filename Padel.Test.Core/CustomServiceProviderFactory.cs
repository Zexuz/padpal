using System;
using Autofac.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection;

namespace Padel.Test.Core
{
    /// <summary>
    /// Based upon https://github.com/dotnet/aspnetcore/issues/14907#issuecomment-620750841 - only necessary because of an issue in ASP.NET Core
    /// </summary>
    public class CustomServiceProviderFactory : IServiceProviderFactory<CustomContainerBuilder>
    {
        public CustomContainerBuilder CreateBuilder(IServiceCollection services) => new CustomContainerBuilder(services);

        public IServiceProvider CreateServiceProvider(CustomContainerBuilder containerBuilder) =>
            new AutofacServiceProvider(containerBuilder.CustomBuild());
    }
}