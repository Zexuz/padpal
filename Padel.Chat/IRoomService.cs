using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IRoomService
    {
        Task<ChatRoom> CreateRoom(UserId adminUserId, string initMessage, IReadOnlyList<UserId> participants);
        Task<ChatRoom> GetRoom(UserId    userId,      RoomId roomId);
    }
}