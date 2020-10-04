using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Services.Interface
{
    public interface IRoomService
    {
        Task<ChatRoom>                      CreateRoom(UserId adminUserId, string initMessage, IReadOnlyList<UserId> participants);
        Task<ChatRoom>                      GetRoom(UserId    userId,      RoomId roomId);
        Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId);
    }
}