using System;
using FluentMigrator.Runner;
using Microsoft.Extensions.DependencyInjection;
using Padel.Identity.Migrations;

namespace Padel.Identity
{
    public class Main
    {
        private readonly string _connectionString;

        public Main(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void Migrate()
        {
            var serviceProvider = CreateServices();

            using var scope = serviceProvider.CreateScope();
            UpdateDatabase(scope.ServiceProvider);
        }

        private IServiceProvider CreateServices()
        {
            return new ServiceCollection()
                // Add common FluentMigrator services
                .AddFluentMigratorCore()
                .ConfigureRunner(rb => rb
                    .AddSqlServer()
                    .WithGlobalConnectionString(_connectionString)
                    // Define the assembly containing the migrations
                    .ScanIn(typeof(InitTables).Assembly).For.Migrations())
                // Enable logging to console in the FluentMigrator way
                .AddLogging(lb => lb.AddFluentMigratorConsole())
                .BuildServiceProvider(false);
        }


        private static void UpdateDatabase(IServiceProvider serviceProvider)
        {
            // Instantiate the runner
            var runner = serviceProvider.GetRequiredService<IMigrationRunner>();

            // Execute the migrations
            runner.MigrateUp();
        }
    }
}