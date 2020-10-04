using System;
using Padel.Social.Services.Interface;

namespace Padel.Social.Services.Impl
{
    public class RoomIdGeneratorService : IRoomIdGeneratorService
    {
        public string GenerateNewRoomId()
        {
            return Guid.NewGuid().ToString("N");
        }
    }
}