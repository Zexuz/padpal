using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;
using Xunit;

namespace Padel.Chat.Test
{
    public class ConversationServiceTest
    {
        private readonly ConversationService _sut;
        private readonly IRoomService        _fakeRoomService;
        private readonly IRoomRepository     _fakeRoomRepository;
        private readonly IMessageFactory     _fakeMessageFactory;

        public ConversationServiceTest()
        {
            _fakeRoomRepository = A.Fake<IRoomRepository>();
            _fakeRoomService = A.Fake<IRoomService>();
            _fakeMessageFactory = A.Fake<IMessageFactory>();

            _sut = new ConversationService(_fakeRoomRepository, _fakeMessageFactory, _fakeRoomService);
        }

        [Fact]
        public async Task GetRoomsWhereUserIsParticipant_should_return_rooms_where_user_is_a_participant()
        {
            var userId = new UserId(4);

            A.CallTo(() => _fakeRoomRepository.GetRoomsWhereUsersIsParticipant(userId)).Returns(new List<ChatRoom>
            {
                new ChatRoom(),
                new ChatRoom(),
                new ChatRoom(),
            });

            var rooms = await _sut.GetRoomsWhereUserIsParticipant(userId);

            Assert.Equal(3, rooms.Count);
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

            A.CallTo(() => _fakeRoomService.GetRoom(userId,roomId)).Returns(originalChatRoom);
            A.CallTo(() => _fakeMessageFactory.Build(A<UserId>._, A<string>._)).Returns(message);

            await _sut.SendMessage(userId, roomId, content);

            A.CallTo(() => _fakeRoomService.GetRoom(userId,roomId)).MustHaveHappened();
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