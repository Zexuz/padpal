using System.Linq;
using Padel.Notification.Models;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Repository
{
    public class UserRepository : MongoRepository<User>, IUserRepository
    {
        public UserRepository(IMongoDbSettings settings) : base(settings)
        {
        }

        public User? FindByUserId(int userId)
        {
            return FilterBy(user => user.UserId == userId)?.SingleOrDefault();
        }
    }
}