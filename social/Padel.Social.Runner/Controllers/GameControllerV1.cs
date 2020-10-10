using System.Threading.Tasks;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Proto.Game.V1;
using Padel.Social.Services.Interface;

namespace Padel.Social.Runner.Controllers
{
    public class GameControllerV1 : Game.GameBase
    {
        private readonly ICreateGameService _createGameService;

        public GameControllerV1(ICreateGameService createGameService)
        {
            _createGameService = createGameService;
        }

        public override async Task<CreateGameResponse> CreateGame(CreateGameRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();

            var id = await _createGameService.CreateGame(userId, request);
            return new CreateGameResponse {Id = id.ToString()};
        }
    }
}