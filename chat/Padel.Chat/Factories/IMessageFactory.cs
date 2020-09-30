using Padel.Chat.Models;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Factories
{
    public interface IMessageFactory
    {
        Message Build(UserId author, string content);
    }
}