using System;

namespace Padel.Chat
{
    public class ChatRoom
    {
        public Guid      Id           { get; set; }
        public UserId    Admin        { get; set; }
        public UserId[]  Participants { get; set; }
        public Message[] Messages     { get; set; }
    }
}