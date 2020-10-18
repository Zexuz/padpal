using System;
using System.Threading.Tasks;
using MongoDB.Bson;
using Padel.Proto.Common.V1;
using Padel.Proto.Game.V1;
using Padel.Queue;
using Padel.Social.Exceptions;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;

namespace Padel.Social.Services.Impl
{
    public class JoinGameService : IJoinGameService
    {
        private readonly IFindGameService       _findGameService;
        private readonly IGameRepository        _gameRepository;
        private readonly IPublisher             _publisher;
        private readonly IProfileRepository     _profileRepository;
        private readonly IPublicGameInfoBuilder _publicGameInfoBuilder;

        public JoinGameService(
            IFindGameService       findGameService,
            IGameRepository        gameRepository,
            IPublisher             publisher,
            IProfileRepository     profileRepository,
            IPublicGameInfoBuilder publicGameInfoBuilder
        )
        {
            _findGameService = findGameService;
            _gameRepository = gameRepository;
            _publisher = publisher;
            _profileRepository = profileRepository;
            _publicGameInfoBuilder = publicGameInfoBuilder;
        }

        public async Task RequestToJoinGame(int userId, string gameId)
        {
            if (string.IsNullOrWhiteSpace(gameId))
            {
                throw new ArgumentException("Is null or Empty", nameof(gameId));
            }

            var game = await _findGameService.FindGameById(gameId);
            if (game == null)
            {
                throw new GameNotFoundException(gameId);
            }

            if (game.Creator == userId)
            {
                throw new AlreadyJoinedException(userId, gameId, "Can't join game where you are the creator");
            }

            if (game.Players.Contains(userId))
            {
                throw new AlreadyJoinedException(userId, gameId, "You are already a player in this game");
            }

            if (DateTimeOffset.Now > game.StartDateTime)
            {
                throw new GameAlreadyClosedException("The game has already started");
            }

            game.PlayersRequestedToJoin.Add(userId);
            await _gameRepository.ReplaceOneAsync(game);

            var user = _profileRepository.FindByUserId(userId);
            await _publisher.PublishMessage(new UserRequestedToJoinGame
            {
                Game = await _publicGameInfoBuilder.Build(game),
                User = new User
                {
                    UserId = user.UserId,
                    Name = user.Name,
                    ImgUrl = user.PictureUrl,
                },
            });
        }
    }
}