using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Social.V1;
using Padel.Repository.Core.MongoDb;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Repositories
{
    public interface IProfileRepository : IMongoRepository<Profile>
    {
        Profile FindByUserId(int userId);

        Task<IReadOnlyCollection<Profile>> Search(int myUserId, string searchTerm, SearchForProfileRequest.Types.SearchOptions requestOptions);
    }
}