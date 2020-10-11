using System;
using System.Threading.Tasks;
using FakeItEasy;
using MongoDB.Bson;
using Padel.Proto.Game.V1;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Test.Unit
{
    public class CreateGameServiceTest
    {
        private readonly CreateGameService _sut;
        private          IGameRepository   _fakeGameRepo;

        public CreateGameServiceTest()
        {
            _fakeGameRepo = A.Fake<IGameRepository>();
            _sut = TestHelper.ActivateWithFakes<CreateGameService>(_fakeGameRepo);
        }

        [Fact]
        public async Task Should_add_to_collection()
        {
            const int userId = 4;
            var request = new CreateGameRequest
            {
                Location = new PadelCenter()
                {
                    Name = "Padel Center Delsjön",
                    Point = new Point
                    {
                        Longitude = 12035027,
                        Latitude = 57694470,
                    },
                },
                StartTime = DateTimeOffset.Parse("2020-10-12 20:52").ToUnixTimeSeconds(),
                DurationInMinutes = 90,
                PricePerPerson = 120,
                CourtName = "A24",
                CourtType = CourtType.Indoors,
                AdditionalInformation = "SomeText"
            };

            A.CallTo(() => _fakeGameRepo.InsertOneAsync(A<Models.Game>._)).Invokes(call => ((Models.Game) call.Arguments[0]).Id = ObjectId.GenerateNewId());

            var id = await _sut.CreateGame(userId, request);

            Assert.NotEqual(ObjectId.Empty, id);
            A.CallTo(() => _fakeGameRepo.InsertOneAsync(A<Game>.That.Matches(game =>
                    game.Creator == userId                                                    &&
                    (game.Created - DateTimeOffset.Now < TimeSpan.FromSeconds(10))            &&
                    game.Location.Name            == "Padel Center Delsjön"                   &&
                    game.Location.Point.Longitude == 12035027                                 &&
                    game.Location.Point.Latitude  == 57694470                                 &&
                    game.StartDateTime            == DateTimeOffset.Parse("2020-10-12 20:52") &&
                    game.Duration                 == TimeSpan.FromMinutes(90)                 &&
                    game.PricePerPerson           == 120                                      &&
                    game.CourtName                == "A24"                                    &&
                    game.CourtType                == CourtType.Indoors                        &&
                    game.AdditionalInformation    == "SomeText"
                )
            )).MustHaveHappened();
        }
    }
}