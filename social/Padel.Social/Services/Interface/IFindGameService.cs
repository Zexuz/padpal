using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Game.V1;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Services.Interface
{
    public interface IFindGameService
    {
        Task<IReadOnlyList<Game>> FindGames(GameFilter filter);
        Task<Game> FindGameById(string id);
    }
}