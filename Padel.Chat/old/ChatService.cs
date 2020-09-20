using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.old
{
    public class ChatService
    {
        public event EventHandler<MessageReceivedEventArgs> MessageReceived;

        private List<Message> _messages = new List<Message>();

        public async Task SendMessage(int author, string someTextMessage)
        {
            var message = new Message
            {
                Author = new UserId(author),
                Content = someTextMessage,
                Timestamp = DateTimeOffset.UtcNow
            };
            _messages.Add(message);
            OnMessageReceived(new MessageReceivedEventArgs {Message = message});
        }

        public IReadOnlyList<Message> GetMessages()
        {
            return _messages;
        }

        protected virtual void OnMessageReceived(MessageReceivedEventArgs e)
        {
            MessageReceived?.Invoke(this, e);
        }
    }
}