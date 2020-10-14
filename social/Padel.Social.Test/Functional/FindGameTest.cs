using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver.GeoJsonObjectModel;
using Padel.Proto.Game.V1;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Runner;
using Padel.Test.Core;
using Xunit;
using Xunit.Abstractions;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Test.Functional
{
    public class FindGameTest : IClassFixture<MongoWebApplicationFactory<Startup>>
    {
        private readonly IGameRepository _sut;


        public FindGameTest(MongoWebApplicationFactory<Startup> factoryBase, ITestOutputHelper output)
        {
            _sut = new GameRepository(new MongoDbSettings
            {
                ConnectionString = factoryBase.ConnectionString,
                DatabaseName = factoryBase.DbTestPrefix + TestHelper.RandomString(15)
            }, output.BuildLoggerFor<GameRepository>());
        }

        [Fact]
        public async Task Should_filter_correctly()
        {
            var currentTime = DateTimeOffset.Parse("2020-11-07 00:00 +0000");

            await _sut.InsertManyAsync(new List<Game>
            {
                new Game
                {
                    // Within range
                    Location = new Location {Coordinates = GeoJson.Point(new GeoJson2DCoordinates(11.970466, 57.705780)).ToBsonDocument()},
                    // Withing timespan
                    StartDateTime = currentTime.AddHours(13 + 24)
                },
                new Game
                {
                    // Within range
                    Location = new Location {Coordinates = GeoJson.Point(new GeoJson2DCoordinates(11.970466, 57.705780)).ToBsonDocument()},
                    // Not withing timespan (To large)
                    StartDateTime = currentTime.AddHours(48 + 1)
                },
                new Game
                {
                    // Within range
                    Location = new Location {Coordinates = GeoJson.Point(new GeoJson2DCoordinates(11.970466, 57.705780)).ToBsonDocument()},
                    // Not withing timespan (To small)
                    StartDateTime = currentTime.Subtract(TimeSpan.FromHours(13))
                },
                new Game
                {
                    // outside range
                    Location = new Location {Coordinates = GeoJson.Point(new GeoJson2DCoordinates(10, 55)).ToBsonDocument()},
                    // Not withing timespan (To small)
                    StartDateTime = currentTime.Subtract(TimeSpan.FromHours(13))
                },
                new Game
                {
                    // Within range
                    Location = new Location {Coordinates = GeoJson.Point(new GeoJson2DCoordinates(12.235066, 57.683175)).ToBsonDocument()},
                    // Withing timespan
                    StartDateTime = currentTime.AddHours(23 + 24)
                },
            });


            var filter = new GameFilter
            {
                Center = new Point
                {
                    Latitude = 57.739881,
                    Longitude = 12.116094
                },
                Distance = 10,
                TimeOffset = new GameFilter.Types.TimeOffset
                {
                    Start = currentTime.AddDays(1).ToUnixTimeSeconds(),
                    End = currentTime.AddDays(2).ToUnixTimeSeconds(),
                }
            };

            var games = await _sut.FindWithFilter(filter);

            Assert.Equal(2, games.Count);
        }
    }
}