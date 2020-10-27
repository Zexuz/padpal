using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.Social.V1;
using Message = Padel.Social.Models.Message;

namespace Padel.Social.Services.Interface
{
    public interface IRoomEventHandler
    {
        Task<string> SubscribeToRoom(int userId, string  roomId, IAsyncStreamWriter<SubscribeToRoomResponse> callback);
        Task         EmitMessage(string  roomId, Message message);
        bool         IsIdActive(string   subId);
    }
}