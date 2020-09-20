using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IRoomService
    {
        Task                    SendMessage(int author, RoomId roomId, string content);
        IReadOnlyList<ChatRoom> GetRoom(string  roomId);
    }
}