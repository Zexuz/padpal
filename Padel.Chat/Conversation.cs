using System.Collections.Generic;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class Conversation : IEntity<UserId>
    {
        public UserId       Id          { get; set; }
        public List<RoomId> MyChatRooms { get; set; }
    }
}