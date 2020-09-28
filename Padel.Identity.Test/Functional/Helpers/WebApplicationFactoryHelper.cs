using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Grpc.Net.Client;
using Padel.Identity.Runner;

namespace Padel.Identity.Test.Functional.Helpers
{
    public static class WebApplicationFactoryHelper
    {
        public static GrpcChannel CreateGrpcChannel(this SqlWebApplicationFactory<Startup> factory)
        {
            var client = factory.CreateDefaultClient(new ResponseVersionHandler());
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