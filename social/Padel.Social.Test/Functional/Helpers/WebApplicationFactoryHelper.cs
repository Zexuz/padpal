using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Autofac;
using Grpc.Net.Client;
using Microsoft.AspNetCore.TestHost;
using Padel.Social.Runner;

namespace Padel.Social.Test.Functional.Helpers
{
    public static class WebApplicationFactoryHelper
    {
        public static GrpcChannel CreateGrpcChannel(this MongoWebApplicationFactory<Startup> factory, Dictionary<object, Type> overrides = default)
        {
            void ConfigureTestContainer(ContainerBuilder builder)
            {
                if (overrides == null) return;

                foreach (var (key, value) in overrides)
                {
                    builder.RegisterInstance(key).As(value);
                }
            }


            var client = factory.WithWebHostBuilder(builder =>
                {
                    builder.ConfigureTestContainer<ContainerBuilder>(ConfigureTestContainer);
                })
                .CreateDefaultClient(new ResponseVersionHandler());
            return GrpcChannel.ForAddress(client.BaseAddress, new GrpcChannelOptions
            {
                HttpClient = client
            });
        }

        private class ResponseVersionHandler : DelegatingHandler
        {
            protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
            {
                var response = await base.SendAsync(request, cancellationToken);
                response.Version = request.Version;

                return response;
            }
        }
    }
}