using System.Threading.Tasks;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IMessageSenderService
    {
        Task SendMessage(UserId userId, ChatRoom room, string content);
    }
}