using System.Collections.Generic;
using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Factories
{
    public interface IRoomFactory
    {
        ChatRoom NewRoom(UserId admin, IReadOnlyList<UserId> userIds);
    }
}