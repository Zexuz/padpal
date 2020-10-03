using System.Threading.Tasks;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;
using Padel.Social.Runner;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Functional
{
    public class ProfileSearchServiceTest : IClassFixture<MongoWebApplicationFactory<Startup>>
    {
        private readonly ProfileSearchService   _sut;
        private readonly IMongoRepository<Profile> _mongoRepository;


        public ProfileSearchServiceTest(MongoWebApplicationFactory<Startup> factoryBase)
        {
            _mongoRepository = new MongoRepository<Profile>(new MongoDbSettings
            {
                ConnectionString = factoryBase.ConnectionString,
                DatabaseName = factoryBase.DbTestPrefix + StringGenerator.RandomString(15)
            });

            _sut = new ProfileSearchService(_mongoRepository);
        }


        [Theory]
        [InlineData("Robin")]
        [InlineData("Oliver")]
        [InlineData("Edbom")]
        public async Task Should_find_profiles_based_of_search_term_match_against_names(string searchTerm)
        {
            await _mongoRepository.InsertManyAsync(new[]
            {
                new Profile {Name = "Robin Oliver Edbom", UserId = 1},
                new Profile {Name = "Oliver Edbom Robin", UserId = 2},
                new Profile {Name = "Edbom Robin Oliver", UserId = 3},
                new Profile {Name = "James Black", UserId = 4},
                new Profile {Name = "Sven Svennis Svensson", UserId = 5},
            });

            var res = await _sut.Search(searchTerm);
            Assert.Equal(3, res.Count);
        }
    }
}