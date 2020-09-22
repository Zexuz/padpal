using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.Models;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Services
{
    public interface IConversationService
    {
        Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId);
        Task                                SendMessage(UserId                    userId, RoomId roomId, string content);
    }
}