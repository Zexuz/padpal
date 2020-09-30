using System.Data;
using System.Threading.Tasks;

namespace Padel.Identity.Repositories
{
    public interface IDatabaseConnectionFactory
    {
        Task<IDbConnection> GetNewOpenConnection();
    }
}