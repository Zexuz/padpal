using System;
using System.Threading;
using System.Threading.Tasks;
using Grpc.Health.V1;
using Grpc.HealthCheck;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Hosting;

namespace Padel.Notification.Runner.HealthCheck
{
    // https://www.stevejgordon.co.uk/health-checks-with-grpc-and-asp-net-core-3
    public class StatusService : BackgroundService
    {
        private readonly HealthServiceImpl  _healthService;
        private readonly HealthCheckService _healthCheckService;

        public StatusService(HealthServiceImpl healthService, HealthCheckService healthCheckService)
        {
            _healthService = healthService;
            _healthCheckService = healthCheckService;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                var health = await _healthCheckService.CheckHealthAsync(stoppingToken);

                _healthService.SetStatus("notification.v1.Notification", health.Status == HealthStatus.Healthy
                    ? HealthCheckResponse.Types.ServingStatus.Serving
                    : HealthCheckResponse.Types.ServingStatus.NotServing);

                _healthService.SetStatus(string.Empty, health.Status == HealthStatus.Healthy
                    ? HealthCheckResponse.Types.ServingStatus.Serving
                    : HealthCheckResponse.Types.ServingStatus.NotServing);

                await Task.Delay(TimeSpan.FromSeconds(15), stoppingToken);
            }
        }
    }
}