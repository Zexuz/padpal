using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Chat.Models;
using Padel.Chat.Repositories;
using Padel.Chat.Services.Impl;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;
using Xunit;

namespace Padel.Chat.Test
{
    public class ConversationServiceTest
    {
        private readonly ConversationService   _sut;
        private readonly IRoomService          _fakeRoomService;
        private readonly IMessageSenderService _fakeMessageSenderService;

        public ConversationServiceTest()
        {
            _fakeRoomService = A.Fake<IRoomService>();
            _fakeMessageSenderService = A.Fake<IMessageSenderService>();

            _sut = new ConversationService(_fakeRoomService, _fakeMessageSenderService);
        }

        [Fact]
        public async Task SendMessage_should_add_message_to_room_and_save_to_database()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");
            var content = "padpal is the best!";

            var roomParticipants = new List<UserId>()
            {
                userId
            };

            var originalChatRoom = new ChatRoom
            {
                Admin = new UserId(1337),
                RoomId = roomId,
                Messages = new List<Message>(),
                Participants = roomParticipants
            };

            A.CallTo(() => _fakeRoomService.GetRoom(userId, roomId)).Returns(originalChatRoom);

            await _sut.SendMessage(userId, roomId, content);

            A.CallTo(() => _fakeRoomService.GetRoom(userId, roomId)).MustHaveHappened();
            A.CallTo(() => _fakeMessageSenderService.SendMessage(userId,originalChatRoom,content)).MustHaveHappened();
        }
    }
}