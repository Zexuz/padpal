using System;

namespace Padel.Chat
{
    public class MessageReceivedEventArgs : EventArgs
    {
        public Message Message { get; set; }
    }
}