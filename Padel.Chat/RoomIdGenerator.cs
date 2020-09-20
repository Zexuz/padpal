using System;

namespace Padel.Chat
{
    public class RoomIdGenerator : IRoomIdGenerator
    {
        public string GenerateNewRoomId()
        {
            return Guid.NewGuid().ToString("N");
        }
    }
}