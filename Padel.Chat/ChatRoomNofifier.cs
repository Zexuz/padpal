using System.Collections.Generic;

namespace Padel.Chat
{
    public class ChatRoomNofifier
    {
        private Dictionary<string, List<IMessageWriter>> _subscribers = new Dictionary<string, List<IMessageWriter>>();

        public void AddListener(string roomId, IMessageWriter fakeMessageWriter)
        {
            if (!_subscribers.ContainsKey(roomId))
                _subscribers[roomId] = new List<IMessageWriter>();

            _subscribers[roomId].Add(fakeMessageWriter);
        }

        public void SendMessageToRoom(string roomId, string myMessage)
        {
            if (!_subscribers.ContainsKey(roomId))
                return;

            foreach (var writer in _subscribers[roomId])
            {
                writer.Write(myMessage);
            }
        }
    }
}