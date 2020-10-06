using System.Threading.Tasks;

namespace Padel.Social.Services.Interface
{
    public interface IFriendRequestService
    {
        Task MakeFriendRequest(int fromUserId, int toUserId);
    }
}