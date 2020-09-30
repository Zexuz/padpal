using System.Collections.Generic;
using Padel.Chat.Models;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Factories
{
    public interface IRoomFactory
    {
        ChatRoom NewRoom(UserId userId, IReadOnlyList<UserId> participants);
    }
}