using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.Social.V1;
using Message = Padel.Social.Models.Message;

namespace Padel.Social.Services.Interface
{
    public interface IRoomEventHandler
    {
        void SubscribeToRoom(string roomId, IAsyncStreamWriter<SubscribeToRoomResponse> callback);
        Task EmitMessage(string     roomId, Message                                     message);
    }
}