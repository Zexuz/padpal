using System;

namespace Padel.Chat.old
{
    public class RoomId : ValueType<string>
    {
        public RoomId(string roomId) : base(roomId)
        {
        }

        public override bool IsValid()
        {
            return Guid.TryParse(Value, out _);
        }
    }
}