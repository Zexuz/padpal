using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FakeItEasy;
using MongoDB.Bson;
using Padel.Proto.Game.V1;
using Padel.Social.Exceptions;
using Padel.Social.Extensions;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Test.Unit
{
    public class CreateGameServiceTest
    {
        private readonly CreateGameService  _sut;
        private readonly IGameRepository    _fakeGameRepo;
        private readonly IProfileRepository _fakeProfileRepository;

        public CreateGameServiceTest()
        {
            _fakeGameRepo = A.Fake<IGameRepository>();
            _fakeProfileRepository = A.Fake<IProfileRepository>();
            _sut = TestHelper.ActivateWithFakes<CreateGameService>(_fakeGameRepo, _fakeProfileRepository);
        }

        [Fact]
        public async Task Should_add_to_collection()
        {
            const int userId = 4;
            var request = new CreateGameRequest
            {
                PublicInfo = new PublicGameInfo
                {
                    Location = new PadelCenter()
                    {
                        Name = "Padel Center Delsjön",
                        Point = new Point
                        {
                            Longitude = 12.035027,
                            Latitude = 57.694470,
                        },
                    },
                    StartTime = DateTimeOffset.Parse("2020-10-12 20:52").ToUnixTimeSeconds(),
                    DurationInMinutes = 90,
                    PricePerPerson = 120,
                    CourtType = CourtType.Indoors,
                },
                PrivateInfo = new PrivateGameInfo
                {
                    CourtName = "A24",
                    AdditionalInformation = "SomeText"
                }
            };

            A.CallTo(() => _fakeGameRepo.InsertOneAsync(A<Models.Game>._))
                .Invokes(call => ((Models.Game) call.Arguments[0]).Id = ObjectId.GenerateNewId());

            var id = await _sut.CreateGame(userId, request);

            Assert.NotEqual(ObjectId.Empty, id);
            A.CallTo(() => _fakeGameRepo.InsertOneAsync(A<Game>.That.Matches(game =>
                    game.Creator == userId                                                                                      &&
                    (game.Created - DateTimeOffset.Now < TimeSpan.FromSeconds(10))                                              &&
                    game.Location.Name                                              == "Padel Center Delsjön"                   &&
                    Math.Abs(game.Location.Coordinates.GetLatLng().lng - 12.035027) < 0.001                                     &&
                    Math.Abs(game.Location.Coordinates.GetLatLng().lat - 57.694470) < 0.001                                     &&
                    game.StartDateTime                                              == DateTimeOffset.Parse("2020-10-12 20:52") &&
                    game.Duration                                                   == TimeSpan.FromMinutes(90)                 &&
                    game.PricePerPerson                                             == 120                                      &&
                    game.CourtName                                                  == "A24"                                    &&
                    game.CourtType                                                  == CourtType.Indoors                        &&
                    game.AdditionalInformation                                      == "SomeText"
                )
            )).MustHaveHappened();
        }

        [Theory]
        [InlineData(8, 9, 5, 2, 1, 4)]
        [InlineData(1, 4)]
        [InlineData()]
        [InlineData(1337)]
        public async Task Should_throw_exception_if_inviting_none_friends_to_a_game(params int[] myFriends)
        {
            const int userId = 4;
            var request = new CreateGameRequest
            {
                PublicInfo = new PublicGameInfo
                {
                    Location = new PadelCenter()
                    {
                        Name = "Padel Center Delsjön",
                        Point = new Point
                        {
                            Longitude = 12.035027,
                            Latitude = 57.694470,
                        },
                    },
                    StartTime = DateTimeOffset.Parse("2020-10-12 20:52").ToUnixTimeSeconds(),
                    DurationInMinutes = 90,
                    PricePerPerson = 120,
                    CourtType = CourtType.Indoors,
                },
                PrivateInfo = new PrivateGameInfo
                {
                    CourtName = "A24",
                    AdditionalInformation = "SomeText"
                },
                PlayersToInvite = {8, 9, 6}
            };

            A.CallTo(() => _fakeProfileRepository.FindByUserId(A<int>._))
                .Returns(new Profile {Friends = myFriends.Select(i => new Friend {UserId = i}).ToList()});

            await Assert.ThrowsAsync<NotFriendsException>(() => _sut.CreateGame(userId, request));
        }
        
        [Theory]
        [InlineData(8, 9, 5, 2, 1, 1335)]
        [InlineData(8, 9, 5, 2)]
        public async Task Should_throw_exception_if_inviting_more_than_3_friends(params int[] friendsToInvite)
        {
            const int userId = 4;
            var request = new CreateGameRequest
            {
                PublicInfo = new PublicGameInfo
                {
                    Location = new PadelCenter()
                    {
                        Name = "Padel Center Delsjön",
                        Point = new Point
                        {
                            Longitude = 12.035027,
                            Latitude = 57.694470,
                        },
                    },
                    StartTime = DateTimeOffset.Parse("2020-10-12 20:52").ToUnixTimeSeconds(),
                    DurationInMinutes = 90,
                    PricePerPerson = 120,
                    CourtType = CourtType.Indoors,
                },
                PrivateInfo = new PrivateGameInfo
                {
                    CourtName = "A24",
                    AdditionalInformation = "SomeText"
                },
                PlayersToInvite = {friendsToInvite}
            };

            await Assert.ThrowsAsync<ArgumentException>(() => _sut.CreateGame(userId, request));
        }
        
        [Theory]
        [InlineData(8, 9, 4)]
        public async Task Should_throw_exception_if_inviting_myself(params int[] friendsToInvite)
        {
            const int userId = 4;
            var request = new CreateGameRequest
            {
                PublicInfo = new PublicGameInfo
                {
                    Location = new PadelCenter()
                    {
                        Name = "Padel Center Delsjön",
                        Point = new Point
                        {
                            Longitude = 12.035027,
                            Latitude = 57.694470,
                        },
                    },
                    StartTime = DateTimeOffset.Parse("2020-10-12 20:52").ToUnixTimeSeconds(),
                    DurationInMinutes = 90,
                    PricePerPerson = 120,
                    CourtType = CourtType.Indoors,
                },
                PrivateInfo = new PrivateGameInfo
                {
                    CourtName = "A24",
                    AdditionalInformation = "SomeText"
                },
                PlayersToInvite = {friendsToInvite}
            };

            await Assert.ThrowsAsync<ArgumentException>(() => _sut.CreateGame(userId, request));
        }
    }
}