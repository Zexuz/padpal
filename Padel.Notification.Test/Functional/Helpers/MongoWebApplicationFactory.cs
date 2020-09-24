using System.Collections.Generic;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using MongoDB.Driver;
using Padel.Test.Core;

namespace Padel.Notification.Test.Functional.Helpers
{
    public class MongoWebApplicationFactory<TStartup> : WebApplicationFactoryBase<TStartup> where TStartup : class
    {
        public MongoClient Client { get; }

        public MongoWebApplicationFactory()
        {
            Client = new MongoClient("mongodb://localhost:27017");
        }

        protected override void ConfigureWebHost(IWebHostBuilder service)
        {
            service.UseEnvironment("Testing");

            service.ConfigureAppConfiguration(builder => builder.AddInMemoryCollection(new[]
            {
                new KeyValuePair<string, string>("Connections:MongoDb:padel:url", $"mongodb://localhost:27017"),
                new KeyValuePair<string, string>("Connections:MongoDb:padel:database", DbTestPrefix + RandomSuffix)
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