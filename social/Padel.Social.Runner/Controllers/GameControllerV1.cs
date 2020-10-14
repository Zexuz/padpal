using System.Linq;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Proto.Game.V1;
using Padel.Social.Extensions;
using Padel.Social.Services.Interface;

namespace Padel.Social.Runner.Controllers
{
    public class GameControllerV1 : Game.GameBase
    {
        private readonly ICreateGameService _createGameService;
        private readonly IFindGameService   _findGameService;

        public GameControllerV1(ICreateGameService createGameService, IFindGameService findGameService)
        {
            _createGameService = createGameService;
            _findGameService = findGameService;
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
            return new FindGamesResponse
            {
                Games =
                {
                    games.Select(game => new PublicGameInfo
                    {
                        Id = game.Id.ToString(),
                        Location = new PadelCenter
                        {
                            Name = game.Location.Name,
                            Point = new Point
                            {
                                Latitude = game.Location.Coordinates.GetLatLng().lat,
                                Longitude = game.Location.Coordinates.GetLatLng().lng,
                            }
                        },
                        CourtType = game.CourtType,
                        StartTime = game.StartDateTime.ToUnixTimeSeconds(),
                        DurationInMinutes = (int) game.Duration.TotalMinutes,
                        PricePerPerson = game.PricePerPerson
                    })
                }
            };
        }
    }
}