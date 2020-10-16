using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Social.V1;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Services.Impl
{
    public class ProfileSearchService : IProfileSearchService
    {
        private readonly IProfileRepository _profileRepository;

        public ProfileSearchService(IProfileRepository profileRepository)
        {
            _profileRepository = profileRepository;
        }

        public async Task<IReadOnlyCollection<Profile>> Search(int myUserId, string searchTerm,
            SearchForProfileRequest.Types.SearchOptions            requestOptions)
        {
            
            // TODO MOVE THIS INTO SEARCH SERVICE!
            // if (string.IsNullOrWhiteSpace(request.SearchTerm))
            // {
                // return new SearchForProfileResponse();
            // }

            // var term = request.SearchTerm.Trim();
            // if (term.Length < 3)
            // {
                // return new SearchForProfileResponse();
            // }
            
            return await _profileRepository.Search(myUserId, searchTerm, requestOptions);
        }
    }
}