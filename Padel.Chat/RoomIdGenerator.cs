using System;

namespace Padel.Chat.Test
{
    public class RoomIdGenerator : IRoomIdGenerator
    {
        public string GenerateNewRoomId()
        {
            return Guid.NewGuid().ToString("N");
        }
    }
}