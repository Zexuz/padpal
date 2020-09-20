using System;

namespace Padel.Chat.old
{
    public class MessageReceivedEventArgs : EventArgs
    {
        public Message Message { get; set; }
    }
}