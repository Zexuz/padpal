using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using MongoDB.Bson;
using Padel.Proto.Game.V1;
using Padel.Queue;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Social.Services.Interface;
using Padel.Test.Core;
using Xunit;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Test.Unit
{
    public class JoinGameServiceTest
    {
        private readonly JoinGameService        _sut;
        private readonly IFindGameService       _fakeFindGameService;
        private readonly IGameRepository        _fakeGameRepo;
        private readonly IPublisher             _fakePublisher;
        private readonly IProfileRepository     _fakeProfileRepository;
        private readonly IPublicGameInfoBuilder _fakePublicGameInfoBuilder;

        public JoinGameServiceTest()
        {
            _fakeFindGameService = A.Fake<IFindGameService>();
            _fakeGameRepo = A.Fake<IGameRepository>();
            _fakePublisher = A.Fake<IPublisher>();
            _fakeProfileRepository = A.Fake<IProfileRepository>();
            _fakePublicGameInfoBuilder = A.Fake<IPublicGameInfoBuilder>();
            
            _sut = TestHelper.ActivateWithFakes<JoinGameService>(
                _fakeFindGameService,
                _fakePublicGameInfoBuilder,
                _fakeProfileRepository,
                _fakeGameRepo,
                _fakePublisher
            );
        }


        [Fact]
        public async Task RequestToJoinGame_Should_throw_if_trying_to_join_our_own_game()
        {
            var userId = 4;
            var gameId = "someId";

            A.CallTo(() => _fakeFindGameService.FindGameById(gameId)).Returns(new Game {Creator = userId});

            var ex = await Assert.ThrowsAsync<AlreadyJoinedException>(() => _sut.RequestToJoinGame(userId, gameId));
            Assert.Equal("Can't join game where you are the creator", ex.Message);
        }

        [Fact]
        public async Task RequestToJoinGame_Should_throw_if_trying_to_join_a_game_that_we_already_is_in()
        {
            var userId = 4;
            var gameId = "someId";

            A.CallTo(() => _fakeFindGameService.FindGameById(gameId)).Returns(new Game {Creator = 0, Players = new List<int> {5, userId, 1335}});

            var ex = await Assert.ThrowsAsync<AlreadyJoinedException>(() => _sut.RequestToJoinGame(userId, gameId));
            Assert.Equal("You are already a player in this game", ex.Message);
        }

        [Fact]
        public async Task RequestToJoinGame_Should_throw_if_trying_to_join_a_game_that_we_already_asked_to_join()
        {
            var userId = 4;
            var gameId = "someId";

            A.CallTo(() => _fakeFindGameService.FindGameById(gameId)).Returns(new Game {Creator = 0, PlayersRequestedToJoin = new List<int> {5, userId, 1335}});

            var ex = await Assert.ThrowsAsync<AlreadyRequestedToJoinedException>(() => _sut.RequestToJoinGame(userId, gameId));
            Assert.Equal("You already requested to join this game", ex.Message);
        }

        [Fact]
        public async Task RequestToJoinGame_Should_throw_if_trying_to_join_a_game_that_does_not_exists()
        {
            var userId = 4;
            var gameId = "someId";

            A.CallTo(() => _fakeFindGameService.FindGameById(gameId)).Returns(Task.FromResult<Game>(null));

            await Assert.ThrowsAsync<GameNotFoundException>(() => _sut.RequestToJoinGame(userId, gameId));
        }

        [Fact]
        public async Task RequestToJoinGame_Should_throw_if_trying_to_join_a_game_that_has_already_started()
        {
            var userId = 4;
            var gameId = "someId";

            A.CallTo(() => _fakeFindGameService.FindGameById(gameId))
                .Returns(new Game {StartDateTime = DateTimeOffset.Now.Subtract(TimeSpan.FromMinutes(1))});

            await Assert.ThrowsAsync<GameAlreadyClosedException>(() => _sut.RequestToJoinGame(userId, gameId));
        }

        [Fact]
        public async Task RequestToJoinGame_Should_throw_if_gameId_is_null()
        {
            var userId = 4;
            string gameId = null;

            await Assert.ThrowsAsync<ArgumentException>(() => _sut.RequestToJoinGame(userId, gameId));
        }

        [Fact]
        public async Task RequestToJoinGame_Should_add_player_requestedToJoin()
        {
            var userId = 4;
            string gameId = "5f8c75465e42c8d2da9c3ebe";

            A.CallTo(() => _fakeProfileRepository.FindByUserId(4)).Returns(new Profile
            {
                UserId = 4,
                Name = "Robin Edbom",
                PictureUrl = "pic"
            });

            A.CallTo(() => _fakeFindGameService.FindGameById(gameId)).Returns(new Game
            {
                Id = ObjectId.Parse(gameId),
                StartDateTime = DateTimeOffset.Now.AddDays(1),
                PlayersRequestedToJoin = new List<int> {1337}
            });

            A.CallTo(() => _fakePublicGameInfoBuilder.Build(A<Game>._)).Returns(new PublicGameInfo{Id = "asdasd"});
            
            await _sut.RequestToJoinGame(userId, gameId);

            A.CallTo(() => _fakeGameRepo.ReplaceOneAsync(A<Game>.That.Matches(game =>
                game.PlayersRequestedToJoin.Count == 2 &&
                game.PlayersRequestedToJoin[1]    == 4
            ))).MustHaveHappened();

            A.CallTo(() => _fakePublicGameInfoBuilder.Build(A<Game>._)).MustHaveHappened();
            A.CallTo(() => _fakePublisher.PublishMessage(A<UserRequestedToJoinGame>._)).MustHaveHappened();
        }
    }
}