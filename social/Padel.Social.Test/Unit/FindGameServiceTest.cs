using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Proto.Game.V1;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Test.Unit
{
    public class FindGameServiceTest
    {
        private readonly FindGameService _sut;

        private readonly IGameRepository _fakeGameRepository;

        public FindGameServiceTest()
        {
            _fakeGameRepository = A.Fake<IGameRepository>();
            _sut = TestHelper.ActivateWithFakes<FindGameService>(_fakeGameRepository);
        }


        [Fact]
        public async Task Should_get_all_games_within_filter()
        {
            var filter = new GameFilter();
            var games = new List<Game>
            {
                new Game { },
                new Game { },
            };

            A.CallTo(() => _fakeGameRepository.FindWithFilter(A<GameFilter>._)).Returns(games);

            var res = await _sut.FindGames(filter);

            Assert.Equal(2, res.Count);
            A.CallTo(() => _fakeGameRepository.FindWithFilter(filter)).MustHaveHappened();
        }


        [Fact]
        public void Should_throw_if_no_filter_is_provided()
        {
            Assert.True(false);
        }

        [Fact]
        public void Should_use_max_values_if_filter_values_is_to_big()
        {
            Assert.True(false);
        }
    }

    // TODO This needs to be able to handle pagination in some way!
}