using System.Data;
using System.Threading.Tasks;

namespace Padel.Login.Repositories
{
    public interface IDatabaseConnectionFactory
    {
        Task<IDbConnection> GetNewOpenConnection();
    }
}