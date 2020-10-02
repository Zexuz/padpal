using System;
using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Factories
{
    public class MessageFactory : IMessageFactory
    {
        public Message Build(UserId author, string content)
        {
            return new Message
            {
                Author = author,
                Content = content,
                Timestamp = DateTimeOffset.UtcNow
            };
        }
    }
}