using System;
using FluentMigrator.Runner;
using Microsoft.Extensions.DependencyInjection;
using Padel.Login.Migrations;

namespace Padel.Login
{
    public class Main
    {
        public static void Migrate()
        {
            var serviceProvider = CreateServices();

            using var scope = serviceProvider.CreateScope();
            UpdateDatabase(scope.ServiceProvider);
        }
        
        private static IServiceProvider CreateServices()
        {
            return new ServiceCollection()
                // Add common FluentMigrator services
                .AddFluentMigratorCore()
                .ConfigureRunner(rb => rb
                    .AddSqlServer()
                    .WithGlobalConnectionString("Server=DESKTOP-5UP1TEB;Database=padel;Trusted_Connection=True;")
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