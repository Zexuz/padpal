using System.Threading.Tasks;
using Padel.Notification.Models;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Repository
{
    public interface IUserRepository : IMongoRepository<User>
    {
        Task<User> FindByUserId(int userId);
    }
}