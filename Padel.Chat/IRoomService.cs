using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Chat
{
    public interface IRoomService
    {
        Task                    SendMessage(int author, string roomId, string content);
        IReadOnlyList<ChatRoom> GetRoom(string  roomId);
    }
}