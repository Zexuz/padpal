using System;
using Padel.Social.ValueTypes;

namespace Padel.Social.Models
{
    public class Message
    {
        public UserId         Author    { get; set; }
        public DateTimeOffset Timestamp { get; set; }
        public string         Content   { get; set; }
    }
}