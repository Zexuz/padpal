using System.Data.Common;
using System.Threading.Tasks;

namespace Padel.Login.Test
{
    public interface IDatabaseConnectionFactory
    {
        Task<DbConnection> GetNewOpenConnection();
    }
}