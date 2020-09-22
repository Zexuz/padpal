using System.Threading.Tasks;
using Padel.Chat.Models;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Services.Interface
{
    public interface IMessageSenderService
    {
        Task SendMessage(UserId userId, ChatRoom room, string content);
    }
}