using Padel.Chat.Services;
using Padel.Chat.Services.Impl;
using Xunit;

namespace Padel.Chat.Test
{
    public class RoomIdGeneratorTest
    {
        private readonly RoomIdGeneratorService _sut;

        public RoomIdGeneratorTest()
        {
            _sut = new RoomIdGeneratorService();
        }


        [Fact]
        public void GenerateNewRoomId_should_generate_new_roomId()
        {
            var roomId = _sut.GenerateNewRoomId();

            Assert.InRange(roomId.Length, 32, 32);
        }
    }
}