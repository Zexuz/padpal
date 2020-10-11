using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Game.V1;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Game = Padel.Social.Models.Game;

namespace Padel.Social.Services.Impl
{
    public class FindGameService : IFindGameService
    {
        private readonly IGameRepository _gameRepository;

        public FindGameService(IGameRepository gameRepository)
        {
            _gameRepository = gameRepository;
        }

        public async Task<IReadOnlyList<Game>> FindGames(GameFilter filter)
        {
            return await _gameRepository.FindWithFilter(filter);
        }
    }
}