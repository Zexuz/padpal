using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using FluentAssertions;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;
using Xunit;

namespace Padel.Chat.Test
{
    // We could have a endpoint 'GetRoomIdForP2P(int userId):string, error', it returns error when we are not allow to chat with that person.
    // It return a roomId that than can be used to with SendMessageToRoom(roomId, message). If the roomId does not exists yet, we add it. b/c we already know that this is a valid roomid.rrrrrrrrrrrrrr 

    // Create a collection that keeps track of what conversations that you are currently participating in

    public class ConversationServiceTest
    {
        private readonly ConversationService            _sut;
        private readonly IRepository<Conversation, int> _fakeRepository;
        private readonly IRoomService                   _fakeRoomService;
        private readonly IRoomFactory                   _fakeRoomFactory;
        private readonly IRoomRepository                _fakeRoomRepository;
        private readonly IMessageFactory                _fakeMessageFactory;

        public ConversationServiceTest()
        {
            _fakeRepository = A.Fake<IRepository<Conversation, int>>();
            _fakeRoomRepository = A.Fake<IRoomRepository>();
            _fakeRoomService = A.Fake<IRoomService>();
            _fakeRoomFactory = A.Fake<IRoomFactory>();
            _fakeMessageFactory = A.Fake<IMessageFactory>();

            _sut = new ConversationService(_fakeRepository, _fakeRoomService, _fakeRoomFactory, _fakeRoomRepository, _fakeMessageFactory);
        }

        [Fact]
        public async Task CreateConversation_should_add_conversation()
        {
            const int myUserId = 4;
            var participants = new[] {5, 7, 99};
            var initMessage = "asd";

            var roomId = new RoomId("e885499f-b6ae-472b-8b0b-c06d33558b25");
            var expectedRoom = new ChatRoom
            {
                Admin = new UserId(myUserId),
                Id = roomId,
                Messages = new List<Message>(),
                Participants = new List<UserId>()
            };

            A.CallTo(() => _fakeRoomFactory.NewRoom()).Returns(expectedRoom);
            A.CallTo(() => _fakeRepository.GetAsync(A<int>._)).Returns(Task.FromResult<Conversation>(null));

            var actualRoom = await _sut.CreateRoom(myUserId, initMessage, participants);

            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 4 &&
                conversation.MyChatRooms.Exists(s => s == roomId)
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 5 &&
                conversation.MyChatRooms.Exists(s => s == roomId)
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 7 &&
                conversation.MyChatRooms.Exists(s => s == roomId)
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 99 &&
                conversation.MyChatRooms.Exists(s => s == roomId)
            ))).MustHaveHappened();

            A.CallTo(() => _fakeRoomService.SendMessage(myUserId, roomId, initMessage)).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakeRoomRepository.SaveAsync(expectedRoom)).MustHaveHappened();

            expectedRoom.Should().BeEquivalentTo(actualRoom);
        }

        [Fact]
        public async Task CreateConversation_should_append_room_if_list_already_exists()
        {
            const int myUserId = 4;
            var participants = new[] {5, 7, 99};
            var initMessage = "asd";

            var roomId = new RoomId("e885499f-b6ae-472b-8b0b-c06d33558b25");
            var expectedRoom = new ChatRoom
            {
                Admin = new UserId(myUserId),
                Id = roomId,
                Messages = new List<Message>(),
                Participants = new List<UserId>()
            };

            A.CallTo(() => _fakeRoomFactory.NewRoom()).Returns(expectedRoom);

            A.CallTo(() => _fakeRepository.GetAsync(4)).Returns(new Conversation
                {Id = 4, MyChatRooms = new List<RoomId> {new RoomId("00000001-b6ae-472b-8b0b-c06d33558b25")}});
            A.CallTo(() => _fakeRepository.GetAsync(5)).Returns(Task.FromResult<Conversation>(null));
            A.CallTo(() => _fakeRepository.GetAsync(7)).Returns(Task.FromResult<Conversation>(null));
            A.CallTo(() => _fakeRepository.GetAsync(99)).Returns(new Conversation
            {
                Id = 99,
                MyChatRooms = new List<RoomId>
                {
                    new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25"),
                    new RoomId("00000003-b6ae-472b-8b0b-c06d33558b25")
                }
            });

            var actualRoom = await _sut.CreateRoom(myUserId, initMessage, participants);

            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 4                                                                                      &&
                conversation.MyChatRooms.Exists(r => r.Value == new RoomId("00000001-b6ae-472b-8b0b-c06d33558b25").Value) &&
                conversation.MyChatRooms.Exists(r => r.Value == roomId.Value)                                             &&
                conversation.MyChatRooms.Count == 2
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 5                                          &&
                conversation.MyChatRooms.Exists(r => r.Value == roomId.Value) &&
                conversation.MyChatRooms.Count == 1
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 99                                                                                     &&
                conversation.MyChatRooms.Exists(r => r.Value == new RoomId("00000003-b6ae-472b-8b0b-c06d33558b25").Value) &&
                conversation.MyChatRooms.Exists(r => r.Value == new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25").Value) &&
                conversation.MyChatRooms.Exists(r => r.Value == roomId.Value)                                             &&
                conversation.MyChatRooms.Count == 3
            ))).MustHaveHappened();

            A.CallTo(() => _fakeRoomService.SendMessage(myUserId, roomId, initMessage)).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakeRoomRepository.SaveAsync(expectedRoom)).MustHaveHappened();

            expectedRoom.Should().BeEquivalentTo(actualRoom);
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
        public async Task SendMessage_should_throw_is_user_is_not_a_participant()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(new ChatRoom
            {
                Participants = new List<UserId>()
                {
                    new UserId(1),
                    new UserId(2),
                    new UserId(3)
                }
            });

            var ex = await Assert.ThrowsAsync<UserIsNotARoomParticipantException>(() => _sut.SendMessage(userId, roomId, "content"));
            Assert.Equal(userId, ex.UserId);
        }

        [Fact]
        public async Task SendMessage_should_throw_RoomNotFound()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(Task.FromResult<ChatRoom>(null));

            var ex = await Assert.ThrowsAsync<RoomNotFoundException>(() => _sut.SendMessage(userId, roomId, "content"));
            Assert.Equal(roomId, ex.RoomId);
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

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(originalChatRoom);
            A.CallTo(() => _fakeMessageFactory.Build(A<UserId>._, A<string>._)).Returns(message);

            await _sut.SendMessage(userId, roomId, content);

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).MustHaveHappened();
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