using System;
using System.Threading.Tasks;
using MongoDB.Bson;
using Padel.Proto.Game.V1;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Services.Impl
{
    public class CreateGameService : ICreateGameService
    {
        private readonly IGameRepository _gameRepository;

        public CreateGameService(IGameRepository gameRepository)
        {
            _gameRepository = gameRepository;
        }

        public async Task<ObjectId> CreateGame(int userId, CreateGameRequest request)
        {
            //TODO
            // if courtType if unknown, throw
            // if pricePerPerson is < 0, throw
            
            var game = new Game
            {
                Creator = userId,
                Created = DateTimeOffset.Now,
                Location = request.Location,
                StartDateTime = DateTimeOffset.FromUnixTimeSeconds(request.StartTime),
                Duration = TimeSpan.FromMinutes(request.DurationInMinutes),
                PricePerPerson = request.PricePerPerson,
                CourtName = request.CourtName,
                CourtType = request.CourtType,
                AdditionalInformation = request.AdditionalInformation
            };
            await _gameRepository.InsertOneAsync(game);
            return game.Id;
        }
    }
}