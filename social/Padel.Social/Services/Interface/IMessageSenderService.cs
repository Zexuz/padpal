using System.Threading.Tasks;
using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Services.Interface
{
    public interface IMessageSenderService
    {
        Task SendMessage(UserId userId, ChatRoom room, string content);
    }
}