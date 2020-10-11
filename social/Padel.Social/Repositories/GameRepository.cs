using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using MongoDB.Driver;
using Padel.Proto.Game.V1;
using Padel.Repository.Core.MongoDb;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Repositories
{
    public class GameRepository : MongoRepository<Game>, IGameRepository
    {
        private readonly ILogger<GameRepository> _logger;

        public GameRepository(IMongoDbSettings settings, ILogger<GameRepository> logger) : base(settings)
        {
            _logger = logger;
            var index = Builders<Game>.IndexKeys.Geo2DSphere(game => game.Location.Coordinates);
            _collection.Indexes.CreateOne(new CreateIndexModel<Game>(index));
        }

        public async Task<IReadOnlyList<Game>> FindWithFilter(GameFilter filter)
        {
            var sw = Stopwatch.StartNew();

            var fb = new FilterDefinitionBuilder<Game>().GeoWithinCenterSphere(
                    game => game.Location.Coordinates,
                    filter.Center.Longitude,
                    filter.Center.Latitude,
                    filter.Distance / 6378.0
                ) & new FilterDefinitionBuilder<Game>().Lte(game => game.StartDateTime, DateTimeOffset.FromUnixTimeSeconds(filter.TimeOffset.End))
                  & new FilterDefinitionBuilder<Game>().Gte(game => game.StartDateTime, DateTimeOffset.FromUnixTimeSeconds(filter.TimeOffset.Start));


            var games = new List<Game>();
            var cursor = (await _collection.FindAsync(fb));
            while (await cursor.MoveNextAsync())
            {
                games.AddRange(cursor.Current);
            }

            _logger.LogInformation($"It took {sw.Elapsed.Milliseconds} ms to find games {games.Count} matching the current filter");
            return games;
        }
    }
}