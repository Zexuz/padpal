using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Game.V1;
using Padel.Repository.Core.MongoDb;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Repositories
{
    public class GameRepository : MongoRepository<Game>, IGameRepository
    {
        public GameRepository(IMongoDbSettings settings) : base(settings)
        {
        }

        public Task<IReadOnlyList<Game>> FindWithFilter(GameFilter filter)
        {
            throw new System.NotImplementedException();
        }
    }
}