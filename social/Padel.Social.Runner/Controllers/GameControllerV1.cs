using System.Linq;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Proto.Game.V1;
using Padel.Social.Extensions;
using Padel.Social.Services.Interface;
using Game = Padel.Proto.Game.V1.Game;

namespace Padel.Social.Runner.Controllers
{
    public class GameControllerV1 : Game.GameBase
    {
        private readonly ICreateGameService     _createGameService;
        private readonly IFindGameService       _findGameService;
        private readonly IPublicGameInfoBuilder _publicGameInfoBuilder;

        public GameControllerV1(ICreateGameService createGameService, IFindGameService findGameService, IPublicGameInfoBuilder publicGameInfoBuilder)
        {
            _createGameService = createGameService;
            _findGameService = findGameService;
            _publicGameInfoBuilder = publicGameInfoBuilder;
        }

        public override async Task<CreateGameResponse> CreateGame(CreateGameRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();

            var id = await _createGameService.CreateGame(userId, request);
            return new CreateGameResponse {Id = id.ToString()};
        }


        public override async Task<FindGamesResponse> FindGames(FindGamesRequest request, ServerCallContext context)
        {
            var games = await _findGameService.FindGames(request.Filter);

            var tasks = games.Select(game => _publicGameInfoBuilder.Build(game)).ToList();

            await Task.WhenAll(tasks);

            return new FindGamesResponse
            {
                Games =
                {
                    tasks.Select(task => task.Result)
                }
            };
        }
    }
}