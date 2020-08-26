using System.Data.Common;
using System.Threading.Tasks;

namespace Padel.Login.Repositories
{
    public interface IDatabaseConnectionFactory
    {
        Task<DbConnection> GetNewOpenConnection();
    }
}