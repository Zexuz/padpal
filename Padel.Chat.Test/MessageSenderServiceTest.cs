using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;
using Xunit;

namespace Padel.Chat.Test
{
    public class MessageSenderServiceTest
    {
        private readonly MessageSenderService _sut;
        private readonly IRoomRepository      _fakeRoomRepository;
        private readonly IMessageFactory      _fakeMessageFactory;

        public MessageSenderServiceTest()
        {
            _fakeRoomRepository = A.Fake<IRoomRepository>();
            _fakeMessageFactory = A.Fake<IMessageFactory>();

            _sut = new MessageSenderService(_fakeRoomRepository, _fakeMessageFactory);
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
                Id = roomId,
                Messages = new List<Message>(),
                Participants = roomParticipants
            };

            var message = new Message
            {
                Author = userId,
                Content = content,
                Timestamp = DateTimeOffset.UtcNow
            };

            A.CallTo(() => _fakeMessageFactory.Build(A<UserId>._, A<string>._)).Returns(message);

            await _sut.SendMessage(userId, originalChatRoom, content);

            A.CallTo(() => _fakeRoomRepository.SaveAsync(A<ChatRoom>.That.Matches(room =>
                room.Admin.Value    == originalChatRoom.Admin.Value &&
                room.Id             == roomId                       &&
                room.Messages.Count == 1                            &&
                room.Messages[0]    == message                      &&
                room.Participants   == roomParticipants
            ))).MustHaveHappened();
            A.CallTo(() => _fakeMessageFactory.Build(
                A<UserId>.That.Matches(s => s.Value == message.Author.Value),
                A<string>.That.Matches(s => s       == message.Content)
            )).MustHaveHappened();
        }
    }
}