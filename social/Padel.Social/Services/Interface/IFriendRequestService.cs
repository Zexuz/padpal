using System.Threading.Tasks;
using Padel.Proto.Social.V1;

namespace Padel.Social.Services.Interface
{
    public interface IFriendRequestService
    {
        Task SendFriendRequest(int      fromUserId, int toUserId);
        Task RespondToFriendRequest(int fromUserId,     int toUserId, RespondToFriendRequestRequest.Types.Action action);
    }
}