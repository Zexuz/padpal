using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver.GeoJsonObjectModel;
using Padel.Proto.Game.V1;
using Padel.Queue;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Services.Impl
{
    public class CreateGameService : ICreateGameService
    {
        private readonly IGameRepository    _gameRepository;
        private readonly IProfileRepository _profileRepository;
        private readonly IPublisher         _publisher;

        public CreateGameService(IGameRepository gameRepository, IProfileRepository profileRepository, IPublisher publisher)
        {
            _gameRepository = gameRepository;
            _profileRepository = profileRepository;
            _publisher = publisher;
        }

        public async Task<ObjectId> CreateGame(int userId, CreateGameRequest request)
        {
            //TODO
            // if courtType if unknown, throw
            // if pricePerPerson is < 0, throw
            if (request.PlayersToInvite.Contains(userId))
            {
                throw new ArgumentException("can't invite myself", nameof(request.PlayersToInvite));
            }

            if (request.PlayersToInvite.Count > 3)
            {
                throw new ArgumentException("can't invite more than 3 people", nameof(request.PlayersToInvite));
            }

            var profile = _profileRepository.FindByUserId(userId);
            var hashSet = new HashSet<int>();
            foreach (var friend in profile.Friends)
            {
                hashSet.Add(friend.UserId);
            }

            foreach (var userIdToInvite in request.PlayersToInvite)
            {
                if (hashSet.Contains(userIdToInvite)) continue;

                throw new NotFriendsException($"User {userId} is not friends with {userIdToInvite}");
            }


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

            await _publisher.PublishMessage(new GameCreated
            {
                Creator = profile.Name,
                PublicGameInfo = new PublicGameInfo(request.PublicInfo) {Id = game.Id.ToString()},
                InvitedPlayers = {request.PlayersToInvite}
            });

            return game.Id;
        }
    }
}