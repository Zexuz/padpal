using System.Threading.Tasks;
using MongoDB.Bson;
using Padel.Proto.Game.V1;

namespace Padel.Social.Services.Interface
{
    public interface ICreateGameService
    {
        Task<ObjectId> CreateGame(int userId, CreateGameRequest request);
    }
}