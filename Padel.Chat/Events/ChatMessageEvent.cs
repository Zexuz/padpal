using System.Collections.Generic;

namespace Padel.Chat.Events
{
    public class ChatMessageEvent
    {
        public static string    MessageType  => "ChatMessage";
        public        List<int> Participants { get; set; }
        public        string    Content      { get; set; }
    }
}