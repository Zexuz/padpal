using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver.GeoJsonObjectModel;
using Padel.Proto.Common.V1;
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
                    Name = request.Location.Name,
                    Coordinates = GeoJson.Point(new GeoJson2DCoordinates(
                        request.Location.Point.Longitude,
                        request.Location.Point.Latitude)
                    ).ToBsonDocument()
                },
                StartDateTime = DateTimeOffset.FromUnixTimeSeconds(request.StartTime),
                Duration = TimeSpan.FromMinutes(request.DurationInMinutes),
                PricePerPerson = request.PricePerPerson,
                CourtName = request.CourtName,
                CourtType = request.CourtType,
                AdditionalInformation = request.AdditionalInformation
            };
            await _gameRepository.InsertOneAsync(game);

            await _publisher.PublishMessage(new GameCreated
            {
                PublicGameInfo = new PublicGameInfo()
                {
                    Id = game.Id.ToString(),
                    Creator = new User
                    {
                        UserId = profile.UserId,
                        Name = profile.Name,
                        ImgUrl = profile.PictureUrl,
                    },
                    Location = request.Location,
                    CourtType = request.CourtType,
                    StartTime = request.StartTime,
                    DurationInMinutes = request.DurationInMinutes,
                    PricePerPerson = request.PricePerPerson,
                },
                InvitedPlayers = {request.PlayersToInvite}
            });

            return game.Id;
        }
    }
}