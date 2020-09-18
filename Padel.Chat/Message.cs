using System;

namespace Padel.Chat
{
    public class Message
    {
        public UserId         Author    { get; set; }
        public DateTimeOffset Timestamp { get; set; }
        public string         Content   { get; set; }
    }
}