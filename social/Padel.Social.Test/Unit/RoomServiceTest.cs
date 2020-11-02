using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using FakeItEasy;
using FluentAssertions;
using Padel.Proto.Common.V1;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Exceptions;
using Padel.Social.Factories;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Social.Services.Interface;
using Padel.Social.Test.Unit.Extensions;
using Padel.Social.ValueTypes;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class RoomServiceTest
    {
        private readonly RoomService              _sut;
        private readonly IRoomFactory             _fakeRoomFactory;
        private readonly IRoomRepository          _fakeRoomRepository;
        private readonly IMessageSenderService    _fakeMessageSenderService;
        private readonly IVerifyRoomAccessService _fakeVerifyRoomAccessService;

        public RoomServiceTest()
        {
            _fakeRoomRepository = A.Fake<IRoomRepository>();
            _fakeRoomFactory = A.Fake<IRoomFactory>();
            _fakeMessageSenderService = A.Fake<IMessageSenderService>();
            _fakeVerifyRoomAccessService = A.Fake<IVerifyRoomAccessService>();

            _sut = TestHelper.ActivateWithFakes<RoomService>(
                _fakeRoomFactory,
                _fakeRoomRepository,
                _fakeMessageSenderService,
                _fakeVerifyRoomAccessService
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
                Participants = new List<Participant>
                {
                    new Participant
                    {
                        LastSeen = DateTimeOffset.Now,
                        UserId = myUserId
                    }
                }
            };
            expectedRoom.Participants.AddRange(participants.Select(id => new Participant
            {
                UserId = id,
                LastSeen = DateTimeOffset.MinValue,
            }).ToList());

            A.CallTo(() => _fakeRoomFactory.NewRoom(A<UserId>._, A<List<UserId>>._)).Returns(expectedRoom);

            var actualRoom = await _sut.CreateRoom(myUserId, initMessage, participants);

            A.CallTo(() => _fakeMessageSenderService.SendMessage(myUserId, expectedRoom, initMessage)).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakeRoomRepository.InsertOneAsync(expectedRoom)).MustHaveHappened();
            A.CallTo(() => _fakeRoomFactory.NewRoom(myUserId, participants)).MustHaveHappened();

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
                Participants = new List<Participant>
                {
                    new Participant
                    {
                        LastSeen = DateTimeOffset.Now,
                        UserId = myUserId
                    }
                }
            };
            expectedRoom.Participants.AddRange(participants.Select(id => new Participant
            {
                UserId = id,
                LastSeen = DateTimeOffset.MinValue,
            }).ToList());

            A.CallTo(() => _fakeRoomFactory.NewRoom(myUserId, A<List<UserId>>._)).Returns(expectedRoom);

            var actualRoom = await _sut.CreateRoom(myUserId, initMessage, participants);

            A.CallTo(() => _fakeMessageSenderService.SendMessage(myUserId, actualRoom, initMessage)).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeRoomRepository.InsertOneAsync(expectedRoom)).MustHaveHappened();
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
        public async Task Should_throw_if_VerifyUsersAccessToRoom_throws()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("some room id");
            var ex = new UserIsNotARoomParticipantException(userId);

            A.CallTo(() => _fakeVerifyRoomAccessService.VerifyUsersAccessToRoom(A<UserId>._, A<RoomId>._))
                .Throws(ex);

            await Assert.ThrowsAsync<UserIsNotARoomParticipantException>(() => _sut.UpdateLastSeenInRoom(userId, roomId));
        }

        [Fact]
        public async Task Should_update_last_seen_to_current_time()
        {
            var userId = new UserId(4);
            var roomId = new RoomId("some room id");

            A.CallTo(() => _fakeVerifyRoomAccessService.VerifyUsersAccessToRoom(A<UserId>._, A<RoomId>._)).Returns(new ChatRoom
            {
                Participants = new List<Participant>
                {
                    new Participant
                    {
                        UserId = userId,
                        LastSeen = DateTimeOffset.MinValue
                    }
                }
            });

            await _sut.UpdateLastSeenInRoom(userId, roomId);

            A.CallTo(() => _fakeRoomRepository.ReplaceOneAsync(A<ChatRoom>.That.Matches(room =>
                room.Participants.Count                                         == 1 &&
                room.Participants[0].UserId.Value                               == 4 &&
                (DateTimeOffset.Now - room.Participants[0].LastSeen).Duration() < TimeSpan.FromSeconds(10)
            ))).MustHaveHappened();
        }
    }
}