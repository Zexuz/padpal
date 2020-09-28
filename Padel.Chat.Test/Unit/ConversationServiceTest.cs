using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Chat.Events;
using Padel.Chat.Models;
using Padel.Chat.Services.Impl;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;
using Padel.Queue;
using Xunit;

namespace Padel.Chat.Test.Unit
{
    public class ConversationServiceTest
    {
        private readonly ConversationService   _sut;
        private readonly IRoomService          _fakeRoomService;
        private readonly IMessageSenderService _fakeMessageSenderService;
        private readonly IPublisher            _fakePublisher;

        public ConversationServiceTest()
        {
            _fakeRoomService = A.Fake<IRoomService>();
            _fakeMessageSenderService = A.Fake<IMessageSenderService>();
            _fakePublisher = A.Fake<IPublisher>();

            _sut = new ConversationService(_fakeRoomService, _fakeMessageSenderService, _fakePublisher);
        }

        [Fact]
        public async Task SendMessage_should_add_message_to_room_and_save_to_database()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");
            var content = "padpal is the best!";

            var roomParticipants = new List<UserId>()
            {
                userId,
                new UserId(789),
                new UserId(1325)
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
            A.CallTo(() => _fakeMessageSenderService.SendMessage(userId, originalChatRoom, content)).MustHaveHappened();
            A.CallTo(() => _fakePublisher.PublishMessage(A<object>.That.Matches(o => 
                o.GetType() == typeof(ChatMessageEvent) &&
                ((ChatMessageEvent)o).Participants.Count == 3 &&
                ((ChatMessageEvent)o).Content == content 
            ))).MustHaveHappened();
        }
    }
}