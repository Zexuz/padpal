using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Social.ValueTypes;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class VerifyRoomAccessServiceTest
    {
        private readonly IRoomRepository         _fakeRoomRepository;
        private readonly VerifyRoomAccessService _sut;

        public VerifyRoomAccessServiceTest()
        {
            _fakeRoomRepository = A.Fake<IRoomRepository>();

            _sut = TestHelper.ActivateWithFakes<VerifyRoomAccessService>(_fakeRoomRepository);
        }

        [Fact]
        public async Task GetRoom_throws_exception_when_not_found()
        {
            var userId = new UserId(4);

            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(Task.FromResult<ChatRoom>(null));

            var ex = await Assert.ThrowsAsync<RoomNotFoundException>(() => _sut.VerifyUsersAccessToRoom(userId, roomId));
            Assert.Equal(roomId, ex.RoomId);
        }

        [Fact]
        public async Task GetRoom_throws_exception_if_user_is_not_a_participant()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");

            var chatRoom = new ChatRoom
            {
                Admin = new UserId(1337),
                RoomId = roomId,
                Messages = new List<Message>(),
                Participants = new List<Participant>
                {
                    new Participant
                    {
                        UserId = new UserId(5748),
                    }
                }
            };

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(chatRoom);

            var ex = await Assert.ThrowsAsync<UserIsNotARoomParticipantException>(() => _sut.VerifyUsersAccessToRoom(userId, roomId));
            Assert.Equal(userId, ex.UserId);
        }

        [Fact]
        public async Task GetRoom_returns_chatroom()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");

            var chatRoom = new ChatRoom
            {
                Admin = new UserId(1337),
                RoomId = roomId,
                Messages = new List<Message>(),
                Participants = new List<Participant>
                {
                    new Participant
                    {
                        UserId = new UserId(4),
                    }
                }
            };

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(chatRoom);

            var room = await _sut.VerifyUsersAccessToRoom(userId, roomId);

            Assert.Equal(chatRoom, room);
        }
    }
}