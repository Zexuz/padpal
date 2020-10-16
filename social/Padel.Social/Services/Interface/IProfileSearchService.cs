using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Social.V1;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Services.Interface
{
    public interface IProfileSearchService
    {
        Task<IReadOnlyCollection<Profile>> Search(int myUserId, string searchTerm, SearchForProfileRequest.Types.SearchOptions requestOptions);
    }
}