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
        private readonly IJoinGameService       _joinGameService;

        public GameControllerV1(
            ICreateGameService     createGameService,
            IFindGameService       findGameService,
            IPublicGameInfoBuilder publicGameInfoBuilder,
            IJoinGameService       joinGameService
        )
        {
            _createGameService = createGameService;
            _findGameService = findGameService;
            _publicGameInfoBuilder = publicGameInfoBuilder;
            _joinGameService = joinGameService;
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

        public override async Task<RequestToJoinGameResponse> RequestToJoinGame(RequestToJoinGameRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();

            await _joinGameService.RequestToJoinGame(userId, request.Id);

            return new RequestToJoinGameResponse();
        }

        public override async Task<AcceptRequestToJoinGameResponse> AcceptRequestToJoinGame
        (
            AcceptRequestToJoinGameRequest request,
            ServerCallContext              context
        )
        {
            var meId = context.GetUserId();

            await _joinGameService.AcceptRequestToJoinGame(meId, request.UserId, request.GameId);

            return new AcceptRequestToJoinGameResponse();
        }
    }
}