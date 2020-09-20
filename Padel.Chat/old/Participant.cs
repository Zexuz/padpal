using System;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.old
{
    public class Participant
    {
        public UserId         UserId         { get; set; }
        public DateTimeOffset LastSeenInChat { get; set; }
    }
}