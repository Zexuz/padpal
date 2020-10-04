using Padel.Social.Services.Impl;
using Xunit;

namespace Padel.Social.Test.Unit
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