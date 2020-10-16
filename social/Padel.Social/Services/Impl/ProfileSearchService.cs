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
            if (string.IsNullOrWhiteSpace(searchTerm))
            {
                return new List<Profile>();
            }

            var term = searchTerm.Trim();
            if (term.Length < 3)
            {
                return new List<Profile>();
            }

            return await _profileRepository.Search(myUserId, term, requestOptions);
        }
    }
}