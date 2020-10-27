using System;
using System.Threading;
using System.Threading.Tasks;
using FakeItEasy;
using Grpc.Core;
using Microsoft.Extensions.Configuration;
using Padel.Proto.Social.V1;
using Padel.Social.Exceptions;
using Padel.Social.Services.Impl;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class RoomEventHandlerTest
    {
        private readonly RoomEventHandler                            _sut;
        private readonly IAsyncStreamWriter<SubscribeToRoomResponse> _fakeAsyncStreamWriter;
        private readonly IGuidGeneratorService                       _fakeGuidGeneratorService;
        private readonly IVerifyRoomAccessService                    _fakeVerifyRoomAccessService;

        public RoomEventHandlerTest()
        {
            _fakeAsyncStreamWriter = A.Fake<IAsyncStreamWriter<SubscribeToRoomResponse>>();
            _fakeGuidGeneratorService = A.Fake<IGuidGeneratorService>();
            _fakeVerifyRoomAccessService = A.Fake<IVerifyRoomAccessService>();

            var fakeConfig = A.Fake<IConfiguration>();
            A.CallTo(() => fakeConfig["ROOM_EVENT_HANDLER:MAX_CONNECTION_TIME"]).Returns("0");
            _sut = TestHelper.ActivateWithFakes<RoomEventHandler>(fakeConfig, _fakeGuidGeneratorService, _fakeVerifyRoomAccessService);
        }

        [Fact]
        public async Task Should_remove_old_connections()
        {
            var userId = 4;
            var roomId = "my room";
            var token = new CancellationTokenSource();

            var subId = await _sut.SubscribeToRoom(userId, roomId, _fakeAsyncStreamWriter);
            Assert.True(_sut.IsIdActive(subId));

            await _sut.StartAsync(token.Token);
            await Task.Delay(100);

            token.Cancel();
            Assert.False(_sut.IsIdActive(subId));
        }


        [Fact]
        public async Task Should_return_id_when_subscribing()
        {
            int userId = 4;

            A.CallTo(() => _fakeGuidGeneratorService.GenerateNewId()).Returns("my new id");

            var id = await _sut.SubscribeToRoom(4, "someRoom", _fakeAsyncStreamWriter);

            Assert.Equal("my new id", id);
        }

        [Fact]
        public async Task Should_throw_if_user_does_not_have_access_to_room()
        {
            var userId = 4;
            var roomId = "someRoomId";

            A.CallTo(() => _fakeVerifyRoomAccessService.VerifyUsersAccessToRoom(
                A<UserId>.That.Matches(id => id.Value == userId),
                A<RoomId>.That.Matches(id => id.Value == roomId)
            )).Throws(new UserIsNotARoomParticipantException(new UserId(userId)));

            await Assert.ThrowsAnyAsync<Exception>(() => _sut.SubscribeToRoom(userId, roomId, _fakeAsyncStreamWriter));

            A.CallTo(() => _fakeGuidGeneratorService.GenerateNewId()).MustNotHaveHappened();

            A.CallTo(() => _fakeVerifyRoomAccessService.VerifyUsersAccessToRoom(A<UserId>._, A<RoomId>._)).MustHaveHappened();
        }

        [Fact]
        public async Task Should_return_true_when_providing_a_active_subscription_id()
        {
            int userId = 4;

            A.CallTo(() => _fakeGuidGeneratorService.GenerateNewId()).Returns("my new id");

            var id = await _sut.SubscribeToRoom(4, "someRoom", _fakeAsyncStreamWriter);

            var result = _sut.IsIdActive(id);

            Assert.True(result);
        }

        [Fact]
        public async Task Should_return_true_when_providing_a_id_that_does_not_exists()
        {
            var result = _sut.IsIdActive("Some random id");

            Assert.False(result);
        }

        [Fact]
        public async Task Should_write_to_callback_when_a_new_message_is_sent()
        {
            int userId = 4;
            await _sut.SubscribeToRoom(4, "someRoom", _fakeAsyncStreamWriter);

            await _sut.EmitMessage("someRoom",
                new Models.Message {Author = new UserId(1), Content = "someContent", Timestamp = DateTimeOffset.Now});

            A.CallTo(() => _fakeAsyncStreamWriter.WriteAsync(A<SubscribeToRoomResponse>.That.Matches(response =>
                response.NewMessage.Author  == 1 &&
                response.NewMessage.Content == "someContent"
            ))).MustHaveHappened();
        }

        [Fact]
        public async Task Should_not_write_to_callback_when_there_are_no_callbacks()
        {
            var message = new Models.Message {Author = new UserId(1), Content = "someContent", Timestamp = DateTimeOffset.Now};

            await _sut.EmitMessage("someRoom", message);

            A.CallTo(() => _fakeAsyncStreamWriter.WriteAsync(A<SubscribeToRoomResponse>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_remove_callback_if_callback_throws()
        {
            int userId = 4;
            var message = new Models.Message {Author = new UserId(userId), Content = "someContent", Timestamp = DateTimeOffset.Now};
            A.CallTo(() => _fakeAsyncStreamWriter.WriteAsync(A<SubscribeToRoomResponse>._)).Throws(new Exception());
            var subId = await _sut.SubscribeToRoom(userId, "someRoom", _fakeAsyncStreamWriter);

            await _sut.EmitMessage("someRoom", message);

            var res = _sut.IsIdActive(subId);
            Assert.False(res);
        }
    }
}