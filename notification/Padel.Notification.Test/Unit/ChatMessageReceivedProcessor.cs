using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Notification.Extensions;
using Padel.Notification.MessageProcessors;
using Padel.Notification.Service;
using Padel.Proto.Notification.V1;
using Padel.Proto.Social.V1;
using Padel.Test.Core;
using Xunit;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.Test.Unit
{
    public class ChatMessageReceivedProcessorTest
    {
        private readonly ChatMessageReceivedProcessor _sut;
        private readonly INotificationService         _fakeNotificationService;

        public ChatMessageReceivedProcessorTest()
        {
            _fakeNotificationService = A.Fake<INotificationService>();
            _sut = TestHelper.ActivateWithFakes<ChatMessageReceivedProcessor>(_fakeNotificationService);
        }

        [Fact]
        public void Should_return_true()
        {
            var res = _sut.CanProcess(ChatMessageReceived.Descriptor.GetMessageName());
            Assert.True(res);
        }

        [Fact]
        public async Task Should_create_pushNotification()
        {
            var json = JsonSerializer.Serialize(new ChatMessageReceived
            {
                Participants = {1337, 4, 5},
                RoomId = "myRoom"
            }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase});

            await _sut.ProcessAsync(new Message {Body = json});

            A.CallTo(() => _fakeNotificationService.AddAndSendNotification(
                A<IEnumerable<int>>.That.Matches(i => i.Count()                        == 3),
                A<PushNotification>.That.Matches(not => not.ChatMessageReceived.RoomId == "myRoom")
            )).MustHaveHappenedOnceExactly();
        }
    }
}