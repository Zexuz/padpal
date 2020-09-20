using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IMessageFactory
    {
        Message Build(UserId author, string content);
    }
}