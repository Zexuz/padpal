using System.Collections.Generic;
using Padel.Chat.old;

namespace Padel.Chat
{
    public class Conversation : IEntity<int>
    {
        public int          Id          { get; set; } // The userId
        public List<string> MyChatRooms { get; set; } // List of all the rooms that I am participating in.
    }
}