using System;
using System.Threading.Tasks;
using FakeItEasy;
using Grpc.Core;
using Padel.Proto.Social.V1;
using Padel.Social.Services.Impl;
using Padel.Social.ValueTypes;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class RoomEventHandlerTest
    {
        private readonly RoomEventHandler                            _sut;
        private readonly IAsyncStreamWriter<SubscribeToRoomResponse> _fakeAsyncStreamWriter;

        public RoomEventHandlerTest()
        {
            _fakeAsyncStreamWriter = A.Fake<IAsyncStreamWriter<SubscribeToRoomResponse>>();
            _sut = TestHelper.ActivateWithFakes<RoomEventHandler>();
        }


        [Fact]
        public async Task Should_write_to_callback_when_a_new_message_is_sent()
        {
            _sut.SubscribeToRoom("someRoom", _fakeAsyncStreamWriter);
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
    }
}