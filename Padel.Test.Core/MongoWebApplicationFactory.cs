using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using MongoDB.Driver;

namespace Padel.Test.Core
{
    public class MongoWebApplicationFactory<TStartup> : WebApplicationFactoryBase<TStartup> where TStartup : class
    {
        public MongoClient Client           { get; }
        public String      ConnectionString => "mongodb://localhost:27017";


        public MongoWebApplicationFactory()
        {
            Client = new MongoClient(ConnectionString);
        }

        protected override void ConfigureWebHost(IWebHostBuilder service)
        {
            service.UseEnvironment("Testing");

            service.ConfigureAppConfiguration(builder => builder.AddInMemoryCollection(new[]
            {
                new KeyValuePair<string, string>("Connections:MongoDb:padel:url", ConnectionString),
                new KeyValuePair<string, string>("Connections:MongoDb:padel:database", DbTestPrefix + RandomSuffix),
                new KeyValuePair<string, string>("AWS:Region", "eu-north-1"),
            }));
        }

        protected override void Dispose(bool disposing)
        {
            foreach (var document in Client.ListDatabases().ToList())
            {
                var databaseName = document["name"].AsString;
                if (!databaseName.StartsWith(DbTestPrefix)) continue;
                Client.DropDatabase(databaseName);
            }

            base.Dispose(disposing);
        }
    }
}