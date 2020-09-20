using System;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.old
{
    public class Message
    {
        public UserId         Author    { get; set; }
        public DateTimeOffset Timestamp { get; set; }
        public string         Content   { get; set; }
    }
}