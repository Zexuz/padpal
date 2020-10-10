using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;

namespace Padel.Social.Repositories
{
    public class GameRepository : MongoRepository<Game>, IGameRepository
    {
        public GameRepository(IMongoDbSettings settings) : base(settings)
        {
        }
    }
}