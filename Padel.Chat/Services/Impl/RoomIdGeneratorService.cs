using System;
using Padel.Chat.Services.Interface;

namespace Padel.Chat.Services.Impl
{
    public class RoomIdGeneratorService : IRoomIdGeneratorService
    {
        public string GenerateNewRoomId()
        {
            return Guid.NewGuid().ToString("N");
        }
    }
}