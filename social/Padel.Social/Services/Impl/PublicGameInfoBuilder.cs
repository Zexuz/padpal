using System.Linq;
using System.Threading.Tasks;
using Padel.Proto.Game.V1;
using Padel.Social.Extensions;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;

namespace Padel.Social.Services.Impl
{
    public class PublicGameInfoBuilder : IPublicGameInfoBuilder
    {
        private readonly IProfileRepository _profileRepository;

        public PublicGameInfoBuilder(IProfileRepository profileRepository)
        {
            _profileRepository = profileRepository;
        }

        public Task<PublicGameInfo> Build(Models.Game game)
        {
            var creator = _profileRepository.FindByUserId(game.Creator);

            return Task.FromResult(new PublicGameInfo
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
                PricePerPerson = game.PricePerPerson,
                Creator = creator.ToUser(),
                PlayerRequestedToJoin = {game.PlayersRequestedToJoin.Select(userId => _profileRepository.FindByUserId(userId).ToUser())},
            });
        }
    }
}