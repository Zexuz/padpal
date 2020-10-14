using Padel.Repository.Core.MongoDb;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Repositories
{
    public interface IProfileRepository : IMongoRepository<Profile>
    {
        Profile FindByUserId(int userId);
    }
}