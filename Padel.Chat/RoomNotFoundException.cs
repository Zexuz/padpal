using System;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class RoomNotFoundException : Exception
    {
        public RoomId RoomId { get; }

        public RoomNotFoundException(RoomId roomId)
        {
            RoomId = roomId;
        }
    }
}