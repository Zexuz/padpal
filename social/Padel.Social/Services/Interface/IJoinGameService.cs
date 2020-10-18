using System.Threading.Tasks;

namespace Padel.Social.Services.Interface
{
    public interface IJoinGameService
    {
        Task RequestToJoinGame(int userId, string gameId);
    }
}