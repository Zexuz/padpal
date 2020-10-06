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
    public class FriendRequestReceivedProcessorTest
    {
        private readonly FriendRequestReceivedProcessor _sut;
        private readonly INotificationService           _fakeNotificationService;

        public FriendRequestReceivedProcessorTest()
        {
            _fakeNotificationService = A.Fake<INotificationService>();
            _sut = TestHelper.ActivateWithFakes<FriendRequestReceivedProcessor>(_fakeNotificationService);
        }

        [Fact]
        public void Should_return_true()
        {
            var res = _sut.CanProcess(FriendRequestReceived.Descriptor.GetMessageName());
            Assert.True(res);
        }

        [Fact]
        public async Task Should_create_pushNotification()
        {
            var json = JsonSerializer.Serialize(new FriendRequestReceived
            {
                FromUser = new FriendRequestReceived.Types.User
                {
                    Id = 1337,
                    Name = "Robin Edbom"
                },
                ToUser = 1338
            }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase});

            await _sut.ProcessAsync(new Message {Body = json});

            A.CallTo(() => _fakeNotificationService.AddAndSendNotification(
                A<IEnumerable<int>>.That.Matches(i => i.Count() == 1),
                A<PushNotification>.That.Matches(push =>
                    push.FriendRequestReceived.Name == "Robin Edbom" &&
                    push.FriendRequestReceived.UserId   == 1337
                )
            )).MustHaveHappenedOnceExactly();
        }
    }
}