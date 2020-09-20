using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IConversationService
    {
        Task<ChatRoom>                      CreateRoom(int                        adminUserId, string initMessage, IEnumerable<int> participants);
        Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId);
        Task                                SendMessage(UserId                    userId, RoomId roomId, string content);
        Task<ChatRoom> GetRoom(UserId userId, RoomId roomId);
    }
}