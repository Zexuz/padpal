using System;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
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