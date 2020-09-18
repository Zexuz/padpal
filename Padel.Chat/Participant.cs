using System;

namespace Padel.Chat
{
    public class Participant
    {
        public UserId         UserId         { get; set; }
        public DateTimeOffset LastSeenInChat { get; set; }
    }
}