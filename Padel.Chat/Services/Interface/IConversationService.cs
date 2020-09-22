using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.Models;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Services.Interface
{
    public interface IConversationService
    {
        Task                                SendMessage(UserId                    userId, RoomId roomId, string content);
    }
}