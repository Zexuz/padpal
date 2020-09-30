using System;
using Padel.Chat.Models;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Factories
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