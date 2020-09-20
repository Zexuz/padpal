using System;
using Padel.Chat.old;

namespace Padel.Chat
{
    public class ChatRoom : IEntity<RoomId>
    {
        public RoomId    Id           { get; set; }
        public UserId    Admin        { get; set; }
        public UserId[]  Participants { get; set; }
        public Message[] Messages     { get; set; }
    }
}