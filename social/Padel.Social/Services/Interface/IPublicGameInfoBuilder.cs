using System.Threading.Tasks;
using Padel.Proto.Game.V1;

namespace Padel.Social.Services.Interface
{
    public interface IPublicGameInfoBuilder
    {
        Task<PublicGameInfo> Build(Models.Game game);
    }
}