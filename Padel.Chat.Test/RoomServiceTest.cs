using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using FakeItEasy;
using FluentAssertions;
using Padel.Chat.MongoDb;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;
using Xunit;

namespace Padel.Chat.Test
{
    public class RoomServiceTest
    {
        private readonly RoomService                    _sut;
        private readonly IMongoRepository<Conversation> _fakeConversationRepository;
        private readonly IRoomFactory                   _fakeRoomFactory;
        private readonly IRoomRepository                _fakeRoomRepository;
        private          IMessageSenderService          _fakeMessageSenderService;

        public RoomServiceTest()
        {
            _fakeConversationRepository = A.Fake<IMongoRepository<Conversation>>();
            _fakeRoomRepository = A.Fake<IRoomRepository>();
            _fakeRoomFactory = A.Fake<IRoomFactory>();
            _fakeMessageSenderService = A.Fake<IMessageSenderService>();

            _sut = new RoomService(
                _fakeConversationRepository,
                _fakeRoomFactory,
                _fakeRoomRepository,
                _fakeMessageSenderService
            );
        }

        [Fact]
        public async Task CreateConversation_should_add_conversation()
        {
            var myUserId = new UserId(4);
            var participants = new List<UserId> {new UserId(5), new UserId(7), new UserId(99)};
            var initMessage = "asd";

            var roomId = new RoomId("e885499f-b6ae-472b-8b0b-c06d33558b25");
            var expectedRoom = new ChatRoom
            {
                Admin = myUserId,
                RoomId = roomId,
                Messages = new List<Message>(),
                Participants = new List<UserId>{myUserId}
            };
            expectedRoom.Participants.AddRange(participants);

            A.CallTo(() => _fakeRoomFactory.NewRoom(A<UserId>._, A<List<UserId>>._)).Returns(expectedRoom);
            A.CallTo(() => _fakeConversationRepository.FindOneAsync(A<Expression<Func<Conversation, bool>>>._))
                .Returns(Task.FromResult<Conversation>(null));

            var actualRoom = await _sut.CreateRoom(myUserId, initMessage, participants);

            A.CallTo(() => _fakeConversationRepository.InsertOneAsync(A<Conversation>.That.Matches(conversation =>
                conversation.UserId.Value == 4 &&
                conversation.MyChatRooms.Contains(roomId)
            ))).MustHaveHappened();
            A.CallTo(() => _fakeConversationRepository.InsertOneAsync(A<Conversation>.That.Matches(conversation =>
                conversation.UserId.Value == 5 &&
                conversation.MyChatRooms.Contains(roomId)
            ))).MustHaveHappened();
            A.CallTo(() => _fakeConversationRepository.InsertOneAsync(A<Conversation>.That.Matches(conversation =>
                conversation.UserId.Value == 7 &&
                conversation.MyChatRooms.Contains(roomId)
            ))).MustHaveHappened();
            A.CallTo(() => _fakeConversationRepository.InsertOneAsync(A<Conversation>.That.Matches(conversation =>
                conversation.UserId.Value == 99 &&
                conversation.MyChatRooms.Contains(roomId)
            ))).MustHaveHappened();

            A.CallTo(() => _fakeMessageSenderService.SendMessage(myUserId, expectedRoom, initMessage)).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakeRoomRepository.InsertOneAsync(expectedRoom)).MustHaveHappened();

            expectedRoom.Should().BeEquivalentTo(actualRoom);
        }

        [Fact]
        public async Task CreateConversation_should_append_room_if_list_already_exists()
        {
            var myUserId = new UserId(4);
            var participants = new List<UserId> {new UserId(5), new UserId(7), new UserId(99)};
            var initMessage = "asd";

            var roomId = new RoomId("e885499f-b6ae-472b-8b0b-c06d33558b25");
            var expectedRoom = new ChatRoom
            {
                Admin = myUserId,
                RoomId = roomId,
                Messages = new List<Message>(),
                Participants = new List<UserId>{myUserId}
            };
            expectedRoom.Participants.AddRange(participants);

            A.CallTo(() => _fakeRoomFactory.NewRoom(myUserId, A<List<UserId>>._)).Returns(expectedRoom);

            A.CallTo(() => _fakeConversationRepository.FindOneAsync(A<Expression<Func<Conversation, bool>>>._)).ReturnsNextFromSequence(
                new Conversation
                {
                    UserId = new UserId(4),
                    MyChatRooms = new List<RoomId>
                    {
                        new RoomId("00000001-b6ae-472b-8b0b-c06d33558b25")
                    }
                },
                null,
                null,
                new Conversation
                {
                    UserId = new UserId(99),
                    MyChatRooms = new List<RoomId>
                    {
                        new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25"),
                        new RoomId("00000003-b6ae-472b-8b0b-c06d33558b25")
                    }
                });

            var actualRoom = await _sut.CreateRoom(myUserId, initMessage, participants);

            A.CallTo(() => _fakeConversationRepository.ReplaceOneAsync(A<Conversation>.That.Matches(conversation =>
                conversation.UserId.Value == 4                                                                            &&
                conversation.MyChatRooms.Exists(r => r.Value == new RoomId("00000001-b6ae-472b-8b0b-c06d33558b25").Value) &&
                conversation.MyChatRooms.Exists(r => r.Value == roomId.Value)                                             &&
                conversation.MyChatRooms.Count == 2
            ))).MustHaveHappened();
            A.CallTo(() => _fakeConversationRepository.InsertOneAsync(A<Conversation>.That.Matches(conversation =>
                conversation.UserId.Value == 5                                &&
                conversation.MyChatRooms.Exists(r => r.Value == roomId.Value) &&
                conversation.MyChatRooms.Count == 1
            ))).MustHaveHappened();
            A.CallTo(() => _fakeConversationRepository.ReplaceOneAsync(A<Conversation>.That.Matches(conversation =>
                conversation.UserId.Value == 99                                                                           &&
                conversation.MyChatRooms.Exists(r => r.Value == new RoomId("00000003-b6ae-472b-8b0b-c06d33558b25").Value) &&
                conversation.MyChatRooms.Exists(r => r.Value == new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25").Value) &&
                conversation.MyChatRooms.Exists(r => r.Value == roomId.Value)                                             &&
                conversation.MyChatRooms.Count == 3
            ))).MustHaveHappened();

            A.CallTo(() => _fakeMessageSenderService.SendMessage(myUserId, actualRoom, initMessage)).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakeRoomRepository.InsertOneAsync(expectedRoom)).MustHaveHappened();

            expectedRoom.Should().BeEquivalentTo(actualRoom);
        }


        [Fact]
        public async Task GetRoom_throws_exception_when_not_found()
        {
            var userId = new UserId(4);

            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(Task.FromResult<ChatRoom>(null));

            var ex = await Assert.ThrowsAsync<RoomNotFoundException>(() => _sut.GetRoom(userId, roomId));
            Assert.Equal(roomId, ex.RoomId);
        }

        [Fact]
        public async Task GetRoom_throws_exception_is_user_is_not_a_participant()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("00000002-b6ae-472b-8b0b-c06d33558b25");

            var chatRoom = new ChatRoom
            {
                Admin = new UserId(1337),
                RoomId = roomId,
                Messages = new List<Message>(),
                Participants = new List<UserId>
                {
                    new UserId(5748)
                }
            };

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(chatRoom);

            var ex = await Assert.ThrowsAsync<UserIsNotARoomParticipantException>(() => _sut.GetRoom(userId, roomId));
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
                Participants = new List<UserId>
                {
                    new UserId(4)
                }
            };

            A.CallTo(() => _fakeRoomRepository.GetRoom(roomId)).Returns(chatRoom);

            var room = await _sut.GetRoom(userId, roomId);

            Assert.Equal(chatRoom, room);
        }
    }
}