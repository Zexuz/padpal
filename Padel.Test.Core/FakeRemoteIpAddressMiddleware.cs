using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace Padel.Test.Core
{
    public class FakeRemoteIpAddressMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IPAddress       _fakeIpAddress = IPAddress.Parse("127.168.1.32");

        public FakeRemoteIpAddressMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext httpContext)
        {
            httpContext.Connection.RemoteIpAddress = _fakeIpAddress;

            await _next(httpContext);
        }
    }
}