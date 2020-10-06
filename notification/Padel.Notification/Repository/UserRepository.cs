using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Notification.Models;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Repository
{
    public class UserRepository : MongoRepository<User>, IUserRepository
    {
        private readonly ILogger<UserRepository> _logger;

        public UserRepository(IMongoDbSettings settings, ILogger<UserRepository> logger) : base(settings)
        {
            _logger = logger;
        }

        public User? FindByUserId(int userId)
        {
            return FilterBy(user => user.UserId == userId)?.SingleOrDefault();
        }

        public async Task<User> FindOrCreateByUserId(int userId)
        {
            var repoModel = FindByUserId(userId);
            if (repoModel != null)
            {
                return repoModel;
            }

            _logger.LogWarning($"We don't have a user with id '{userId}' in the collection, creating user");

            var user = new User {UserId = userId};
            await InsertOneAsync(user);
            return user;
        }
    }
}