using System.Linq;
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


        [Theory]
        [InlineData(8)]
        [InlineData(8, 45)]
        [InlineData(78, 2, 5478, 46587)]
        public void NewRoom_should_create_room(params int[] userIds)
        {
            A.CallTo(() => _fakeRoomIdGenerator.GenerateNewRoomId()).Returns("SomeRoomId");
            var userId = new UserId(4);

            var room = _sut.NewRoom(userId, userIds.Select(i => new UserId(i)).ToList());

            Assert.Equal("SomeRoomId", room.Id.Value);
            Assert.Empty(room.Messages);
            Assert.Equal(userIds.Length + 1 ,room.Participants.Count);
            Assert.Equal(userId.Value, room.Participants[0].Value);
        }

        [Theory]
        [InlineData(4)]
        [InlineData(8, 8)]
        public void NewRoom_should_throw_if_adding_same_user_twice(params int[] userIds)
        {
            A.CallTo(() => _fakeRoomIdGenerator.GenerateNewRoomId()).Returns("SomeRoomId");
            var userId = new UserId(4);

            Assert.Throws<ParticipantAlreadyAddedException>(() => _sut.NewRoom(userId, userIds.Select(i => new UserId(i)).ToList()));
        }
    }
}