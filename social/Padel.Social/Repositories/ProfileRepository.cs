using System.Linq;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;

namespace Padel.Social.Repositories
{
    public class ProfileRepository : MongoRepository<Profile>, IProfileRepository
    {
        public ProfileRepository(IMongoDbSettings settings) : base(settings)
        {
        }

        public Profile FindByUserId(int userId)
        {
            return FilterBy(user => user.UserId == userId)?.SingleOrDefault();
        }

    }
}