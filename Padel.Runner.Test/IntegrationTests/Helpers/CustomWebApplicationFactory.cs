using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Padel.Runner.Test.IntegrationTests.Helpers
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

    public class CustomStartupFilter : IStartupFilter
    {
        public Action<IApplicationBuilder> Configure(Action<IApplicationBuilder> next)
        {
            return app =>
            {
                app.UseMiddleware<FakeRemoteIpAddressMiddleware>();
                next(app);
            };
        }
    }

    public class CustomWebApplicationFactory<TStartup> : WebApplicationFactory<TStartup> where TStartup : class
    {
        private static Random _random = new Random();

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[_random.Next(s.Length)]).ToArray());
        }

        protected override IHostBuilder CreateHostBuilder()
        {
            return base.CreateHostBuilder().ConfigureServices(services => { services.AddSingleton<IStartupFilter, CustomStartupFilter>(); });
        }

        public CustomWebApplicationFactory()
        {
            RandomSuffix = RandomString(15);
            Db = new SqlConnection("Server=127.0.0.1,1433;Database=master;User=sa;Password=yourStrong(!)Password;");
            Db.ExecuteScalar($"create database padel_test_{RandomSuffix}");
        }

        public string RandomSuffix { get; set; }
        public SqlConnection Db { get; private set; }


        protected override void ConfigureWebHost(IWebHostBuilder service)
        {
            service.UseEnvironment("Testing");

            service.ConfigureAppConfiguration(builder => builder.AddInMemoryCollection(new[]
            {
                new KeyValuePair<string, string>("Connections:Sql:padel",
                    $"Server=127.0.0.1,1433;Database=padel_test_{RandomSuffix};User=sa;Password=yourStrong(!)Password;")
            }));
        }

        protected override void Dispose(bool disposing)
        {
            Db.ExecuteScalar($"ALTER DATABASE padel_test_{RandomSuffix} SET SINGLE_USER WITH ROLLBACK IMMEDIATE;");
            Db.ExecuteScalar($"drop database padel_test_{RandomSuffix}");
            Db.Dispose();
            base.Dispose(disposing);
        }
    }
}