using FakeItEasy;
using Padel.Chat.ValueTypes;
using Xunit;

namespace Padel.Chat.Test
{
    public class RoomFactoryTest
    {
        private readonly RoomFactory      _sut;
        private readonly IRoomIdGenerator _fakeRoomIdGenerator;

        public RoomFactoryTest()
        {
            _fakeRoomIdGenerator = A.Fake<IRoomIdGenerator>();

            _sut = new RoomFactory(_fakeRoomIdGenerator);
        }


        [Fact]
        public void NewRoom_should_create_room()
        {
            A.CallTo(() => _fakeRoomIdGenerator.GenerateNewRoomId()).Returns("SomeRoomId");
            var userId = new UserId(4);

            var room = _sut.NewRoom(userId);

            Assert.Equal("SomeRoomId", room.Id.Value);
            Assert.Empty(room.Messages);
            Assert.Single(room.Participants);
            Assert.Equal(userId.Value, room.Participants[0].Value);
        }
    }
}