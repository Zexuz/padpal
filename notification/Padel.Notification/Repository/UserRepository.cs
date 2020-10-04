using System.Linq;
using System.Threading.Tasks;
using Padel.Notification.Models;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Repository
{
    public class UserRepository : MongoRepository<User>, IUserRepository
    {
        public UserRepository(IMongoDbSettings settings) : base(settings)
        {
        }

        public Task<User> FindByUserId(int userId)
        {
            return Task.FromResult(FilterBy(user => user.UserId == userId).SingleOrDefault());
        }
    }
}