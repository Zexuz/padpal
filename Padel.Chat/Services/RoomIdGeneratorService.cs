using System;

namespace Padel.Chat.Services
{
    public class RoomIdGeneratorService : IRoomIdGeneratorService
    {
        public string GenerateNewRoomId()
        {
            return Guid.NewGuid().ToString("N");
        }
    }
}