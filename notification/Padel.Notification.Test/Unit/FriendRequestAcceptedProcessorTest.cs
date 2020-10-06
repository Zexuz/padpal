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
    public class FriendRequestAcceptedProcessorTest
    {
        private readonly FriendRequestAcceptedProcessor _sut;
        private readonly INotificationService           _fakeNotificationService;

        public FriendRequestAcceptedProcessorTest()
        {
            _fakeNotificationService = A.Fake<INotificationService>();
            _sut = TestHelper.ActivateWithFakes<FriendRequestAcceptedProcessor>(_fakeNotificationService);
        }

        [Fact]
        public void Should_return_true()
        {
            var res = _sut.CanProcess(FriendRequestAccepted.Descriptor.GetMessageName());
            Assert.True(res);
        }

        [Fact]
        public async Task Should_create_pushNotification()
        {
            var json = JsonSerializer.Serialize(new FriendRequestAccepted
            {
                UserThatAccepted = "Robin Edbom",
                UserThatRequested = 1337
            }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase});

            await _sut.ProcessAsync(new Message {Body = json});

            A.CallTo(() => _fakeNotificationService.AddAndSendNotification(
                A<IEnumerable<int>>.That.Matches(i => i.Count()                        == 1),
                A<PushNotification>.That.Matches(push => push.FriendRequestAccepted.Name == "Robin Edbom")
            )).MustHaveHappenedOnceExactly();
        }
    }
}