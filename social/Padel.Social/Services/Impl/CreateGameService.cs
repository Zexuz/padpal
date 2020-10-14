using System;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver.GeoJsonObjectModel;
using Padel.Proto.Game.V1;
using Padel.Social.Models;
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
                Location = new Location
                {
                    Name = request.PublicInfo.Location.Name,
                    Coordinates = GeoJson.Point(new GeoJson2DCoordinates(
                        request.PublicInfo.Location.Point.Longitude,
                        request.PublicInfo.Location.Point.Latitude)
                    ).ToBsonDocument()
                },
                StartDateTime = DateTimeOffset.FromUnixTimeSeconds(request.PublicInfo.StartTime),
                Duration = TimeSpan.FromMinutes(request.PublicInfo.DurationInMinutes),
                PricePerPerson = request.PublicInfo.PricePerPerson,
                CourtName = request.PrivateInfo.CourtName,
                CourtType = request.PublicInfo.CourtType,
                AdditionalInformation = request.PrivateInfo.AdditionalInformation
            };
            await _gameRepository.InsertOneAsync(game);
            return game.Id;
        }
    }
}