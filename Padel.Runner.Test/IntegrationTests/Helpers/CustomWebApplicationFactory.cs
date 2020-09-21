using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
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
using MongoDB.Driver;

namespace Padel.Runner.Test.IntegrationTests.Helpers
{
    public static class StringGenerator
    {
        private static readonly Random _random = new Random();

        public const string Letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        public const string Digits  = "123456789";

        public static string RandomEmail()
        {
            return RandomString(10, Letters) + "@gmail.com";
        }

        public static string RandomUsername()
        {
            return RandomString(10);
        }

        public static string RandomPassword()
        {
            return RandomString(10);
        }


        public static string RandomString(int length, string chars = Letters + Digits)
        {
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[_random.Next(s.Length)]).ToArray());
        }
    }

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
        private readonly MongoClient _client;

        private const string DbTestPrefix = "padpal_test_";

        protected override IHostBuilder CreateHostBuilder()
        {
            return base.CreateHostBuilder().ConfigureServices(services => { services.AddSingleton<IStartupFilter, CustomStartupFilter>(); });
        }

        public CustomWebApplicationFactory()
        {
            RandomSuffix = StringGenerator.RandomString(15);
            Db = new SqlConnection("Server=127.0.0.1,1433;Database=master;User=sa;Password=yourStrong(!)Password;");
            Db.ExecuteScalar($"create database {DbTestPrefix}{RandomSuffix}");

            _client = new MongoClient("mongodb://localhost:27017");
        }

        public string        RandomSuffix { get; set; }
        public SqlConnection Db           { get; private set; }


        protected override void ConfigureWebHost(IWebHostBuilder service)
        {
            service.UseEnvironment("Testing");

            service.ConfigureAppConfiguration(builder => builder.AddInMemoryCollection(new[]
            {
                new KeyValuePair<string, string>("Connections:Sql:padel",
                    $"Server=127.0.0.1,1433;Database={DbTestPrefix}{RandomSuffix};User=sa;Password=yourStrong(!)Password;"),
                new KeyValuePair<string, string>("Connections:MongoDb:padel:url", $"mongodb://localhost:27017"),
                new KeyValuePair<string, string>("Connections:MongoDb:padel:database", DbTestPrefix + RandomSuffix)
            }));
        }

        protected override void Dispose(bool disposing)
        {
            Db.ExecuteScalar($"ALTER DATABASE {DbTestPrefix}{RandomSuffix} SET SINGLE_USER WITH ROLLBACK IMMEDIATE;");
            Db.ExecuteScalar($"drop database {DbTestPrefix}{RandomSuffix}");
            Db.Dispose();

            foreach (var document in _client.ListDatabases().ToList())
            {
                var databaseName = document["name"].AsString;
                if (!databaseName.StartsWith(DbTestPrefix)) continue;
                _client.DropDatabase(databaseName);
            }

            base.Dispose(disposing);
        }
    }
}