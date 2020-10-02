using System;
using Padel.Social.ValueTypes;

namespace Padel.Social.Models
{
    public class Participant
    {
        public UserId         UserId         { get; set; }
        public DateTimeOffset LastSeenInChat { get; set; }
    }
}