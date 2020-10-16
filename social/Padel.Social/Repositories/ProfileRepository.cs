using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using Padel.Proto.Social.V1;
using Padel.Repository.Core.MongoDb;
using Profile = Padel.Social.Models.Profile;

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

        public async Task<IReadOnlyCollection<Profile>> Search(
            int                                         myUserId,
            string                                      searchTerm,
            SearchForProfileRequest.Types.SearchOptions requestOptions
        )
        {
            var profiles = new List<Profile>();
            var fb = new FilterDefinitionBuilder<Profile>().Regex(profile => profile.Name, new BsonRegularExpression($".*{searchTerm}.*", "i"))
                     & (requestOptions.OnlyMyFriends
                         ? new FilterDefinitionBuilder<Profile>().ElemMatch(profile => profile.Friends, friend => friend.UserId == myUserId)
                         : new FilterDefinitionBuilder<Profile>().Empty);

            var cursor = (await _collection.FindAsync(fb));
            while (await cursor.MoveNextAsync())
            {
                profiles.AddRange(cursor.Current);
            }

            return profiles.ToList();
        }
    }
}