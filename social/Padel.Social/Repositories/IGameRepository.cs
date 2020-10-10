using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;

namespace Padel.Social.Repositories
{
    public interface IGameRepository : IMongoRepository<Game>
    {
    }
}