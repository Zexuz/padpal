using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Social.V1;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Runner;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Test.Functional
{
    public class ProfileSearchServiceTest : IClassFixture<MongoWebApplicationFactory<Startup>>
    {
        private readonly ProfileSearchService _sut;
        private readonly ProfileRepository    _mongoRepository;


        public ProfileSearchServiceTest(MongoWebApplicationFactory<Startup> factoryBase)
        {
            _mongoRepository = new ProfileRepository(new MongoDbSettings
            {
                ConnectionString = factoryBase.ConnectionString,
                DatabaseName = factoryBase.DbTestPrefix + TestHelper.RandomString(15)
            });

            _sut = new ProfileSearchService(_mongoRepository);
        }


        [Theory]
        [InlineData("Robin")]
        [InlineData("robin")]
        [InlineData("RoBiN")]
        [InlineData("Oliver")]
        [InlineData("Edbom")]
        public async Task Should_find_profiles_based_of_search_term_match_against_names(string searchTerm)
        {
            const int myUserId = 1337;
            await _mongoRepository.InsertManyAsync(new[]
            {
                new Profile {Name = "Robin Oliver Edbom", UserId = 1},
                new Profile {Name = "Oliver Edbom Robin", UserId = 2},
                new Profile {Name = "Edbom Robin Oliver", UserId = 3},
                new Profile {Name = "James Black", UserId = 4},
                new Profile {Name = "Sven Svennis Svensson", UserId = 5},
            });

            var res = await _sut.Search(myUserId, searchTerm, new SearchForProfileRequest.Types.SearchOptions());
            Assert.Equal(3, res.Count);
        }

        [Theory]
        [InlineData("robin")]
        public async Task Should_find_profiles_that_are_my_only_my_friends(string searchTerm)
        {
            const int myUserId = 1337;
            await _mongoRepository.InsertManyAsync(new[]
            {
                new Profile
                {
                    Name = "Robin My Friend", UserId = 1, Friends = new List<Friend>
                    {
                        new Friend {UserId = 2},
                        new Friend {UserId = myUserId},
                    }
                },
                new Profile
                {
                    Name = "Robin My other Friend", UserId = 2, Friends = new List<Friend>
                    {
                        new Friend {UserId = myUserId},
                        new Friend {UserId = 1},
                    }
                },
                new Profile
                {
                    Name = "Robin not My Friend", UserId = 3, Friends = new List<Friend>
                    {
                        new Friend {UserId = 7},
                        new Friend {UserId = 9},
                    }
                },
            });

            var res = await _sut.Search(myUserId, searchTerm, new SearchForProfileRequest.Types.SearchOptions {OnlyMyFriends = true});
            Assert.Equal(2, res.Count);
        }
    }
}