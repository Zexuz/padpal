using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;

namespace Padel.Login.Test
{
    public class CustomWebApplicationFactory<TStartup> : WebApplicationFactory<TStartup> where TStartup : class
    {
        private static Random random = new Random();

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public CustomWebApplicationFactory()
        {
            RandomSuffix = RandomString(15);
            Db = new SqlConnection("Server=DESKTOP-5UP1TEB;Database=master;Trusted_Connection=True;");
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
                    $"Server=DESKTOP-5UP1TEB;Database=padel_test_{RandomSuffix};Trusted_Connection=True;"),
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