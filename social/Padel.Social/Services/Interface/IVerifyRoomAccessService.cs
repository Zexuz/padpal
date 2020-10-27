using System.Threading.Tasks;
using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Services.Interface
{
    public interface IVerifyRoomAccessService
    {
        Task<ChatRoom> VerifyUsersAccessToRoom(UserId userId, RoomId roomId);
    }
}