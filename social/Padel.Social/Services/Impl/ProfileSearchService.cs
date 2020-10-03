using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;
using Padel.Social.Services.Interface;

namespace Padel.Social.Services.Impl
{
    public class ProfileSearchService : IProfileSearchService
    {
        private readonly IMongoRepository<Profile> _profileRepository;

        public ProfileSearchService(IMongoRepository<Profile> profileRepository)
        {
            _profileRepository = profileRepository;
        }

        public Task<IReadOnlyCollection<Profile>> Search(string searchTerm)
        {
            var res = _profileRepository.FilterBy(profile => profile.Name.Contains(searchTerm));
            return Task.FromResult<IReadOnlyCollection<Profile>>(res.ToList());
        }
    }
}