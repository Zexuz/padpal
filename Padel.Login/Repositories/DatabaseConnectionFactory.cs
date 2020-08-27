using System.Data.Common;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Padel.Login.Repositories
{
    public class DatabaseConnectionFactory : IDatabaseConnectionFactory
    {
        public async Task<DbConnection> GetNewOpenConnection()
        {
            var connection = new SqlConnection("Server=DESKTOP-5UP1TEB;Database=padel;Trusted_Connection=True;"); // TODO MOVE BOTH CONNECTION STRINGS TO APPSETTINGS
            await connection.OpenAsync();
            return connection;
        }
    }
}