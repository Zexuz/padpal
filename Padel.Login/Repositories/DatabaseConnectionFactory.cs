using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace Padel.Login.Repositories
{
    public class DatabaseConnectionFactory : IDatabaseConnectionFactory
    {
        private readonly IConfiguration _configuration;

        public DatabaseConnectionFactory(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task<IDbConnection> GetNewOpenConnection()
        {
            // TODO Move the connection string to a model/option instead.
            var connection = new SqlConnection(_configuration.GetSection("Connections:Sql:padel").Value);
            await connection.OpenAsync();
            return connection;
        }
    }
}