using System.Collections.Generic;
using System.Data.SqlClient;
using Dapper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Padel.Runner.Test.IntegrationTests.Helpers;

namespace Padel.Identity.Runner.Test
{
    public class SqlWebApplicationFactory<TStartup> : WebApplicationFactoryBase<TStartup> where TStartup : class
    {
        public SqlConnection Db { get; private set; }

        public SqlWebApplicationFactory()
        {
            Db = new SqlConnection("Server=127.0.0.1,1433;Database=master;User=sa;Password=yourStrong(!)Password;");
            Db.ExecuteScalar($"create database {DbTestPrefix}{RandomSuffix}");
        }


        protected override void ConfigureWebHost(IWebHostBuilder service)
        {
            service.ConfigureAppConfiguration(builder => builder.AddInMemoryCollection(new[]
            {
                new KeyValuePair<string, string>("Connections:Sql:padel",
                    $"Server=127.0.0.1,1433;Database={DbTestPrefix}{RandomSuffix};User=sa;Password=yourStrong(!)Password;"),
            }));
        }

        protected override void Dispose(bool disposing)
        {
            Db.ExecuteScalar($"ALTER DATABASE {DbTestPrefix}{RandomSuffix} SET SINGLE_USER WITH ROLLBACK IMMEDIATE;");
            Db.ExecuteScalar($"drop database {DbTestPrefix}{RandomSuffix}");
            Db.Dispose();
            base.Dispose(disposing);
        }
    }
}