using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Padel.Social.Factories;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Social.ValueTypes;
using Padel.Test.Core;
using Xunit;
using ChatRoom = Padel.Social.Models.ChatRoom;
using Message = Padel.Social.Models.Message;

namespace Padel.Social.Test.Unit
{
    public class MessageSenderServiceTest
    {
        private readonly MessageSenderService _sut;
        private readonly IRoomRepository      _fakeRoomRepository;
        private readonly IMessageFactory      _fakeMessageFactory;
        private readonly IPublisher           _fakePublisher;

        public MessageSenderServiceTest()
        {
            _fakeRoomRepository = A.Fake<IRoomRepository>();
            _fakeMessageFactory = A.Fake<IMessageFactory>();
            _fakePublisher = A.Fake<IPublisher>();

            _sut = TestHelper.ActivateWithFakes<MessageSenderService>(_fakeRoomRepository, _fakeMessageFactory, _fakePublisher);
        }

        [Fact]
        public async Task SendMessage_should_add_message_to_room_and_save_to_database()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");
            var content = "padpal is the best!";

            var roomParticipants = new List<Models.Participant>()
            {
                new Models.Participant
                {
                    UserId = userId,
                    LastSeen = DateTimeOffset.Now,
                },
                new Models.Participant
                {
                    UserId = new UserId(789),

                    LastSeen = DateTimeOffset.Now,
                },
                new Models.Participant
                {
                    UserId = new UserId(1325),
                    LastSeen = DateTimeOffset.Now,
                },
            };

            var originalChatRoom = new ChatRoom
            {
                Admin = new UserId(1337),
                RoomId = roomId,
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

            A.CallTo(() => _fakeRoomRepository.ReplaceOneAsync(A<ChatRoom>.That.Matches(room =>
                room.Admin.Value == originalChatRoom.Admin.Value &&
                Equals(room.RoomId, roomId)                      &&
                room.Messages.Count == 1                         &&
                room.Messages[0]    == message                   &&
                room.Participants   == roomParticipants
            ))).MustHaveHappened();
            A.CallTo(() => _fakeMessageFactory.Build(
                A<UserId>.That.Matches(s => s.Value == message.Author.Value),
                A<string>.That.Matches(s => s       == message.Content)
            )).MustHaveHappened();
            A.CallTo(() => _fakePublisher.PublishMessage(A<ChatMessageReceived>.That.Matches(o =>
                o.Participants.Count == 3
            ))).MustHaveHappened();
        }
    }
}