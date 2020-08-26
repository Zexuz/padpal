using System.Data.Common;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace Padel.Login.Test
{
    class DatabaseConnectionFactory : IDatabaseConnectionFactory
    {
        public async Task<DbConnection> GetNewOpenConnection()
        {
            var connection = new MySqlConnection("Server=localhost;Port=3306;Database=padel_test;Uid=root;Pwd=password;");
            await connection.OpenAsync();
            return connection;
        }
    }
}