using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Notification.Extensions;
using Padel.Notification.MessageProcessors;
using Padel.Notification.Service;
using Padel.Proto.Game.V1;
using Padel.Proto.Notification.V1;
using Padel.Proto.Social.V1;
using Padel.Test.Core;
using Xunit;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.Test.Unit
{
    public class GameCreatedProcessorTest
    {
        private readonly GameCreatedProcessor _sut;
        private readonly INotificationService _fakeNotificationService;

        public GameCreatedProcessorTest()
        {
            _fakeNotificationService = A.Fake<INotificationService>();
            _sut = TestHelper.ActivateWithFakes<GameCreatedProcessor>(_fakeNotificationService);
        }

        [Fact]
        public void Should_return_true()
        {
            var res = _sut.CanProcess(GameCreated.Descriptor.GetMessageName());
            Assert.True(res);
        }

        [Fact]
        public async Task Should_create_pushNotification()
        {
            var json = JsonSerializer.Serialize(new GameCreated
            {
                Creator = "Robin Edbom",
                InvitedPlayers = {1337, 5},
                PublicGameInfo = new PublicGameInfo
                {
                    Location = new PadelCenter
                    {
                        Name = "Best Padel Center"
                    },
                    StartTime = DateTimeOffset.Parse("2020-11-07 00:00 +0000").ToUnixTimeSeconds(),
                    DurationInMinutes = 90,
                },
            }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase});

            await _sut.ProcessAsync(new Message {Body = json});

            A.CallTo(() => _fakeNotificationService.AddAndSendNotification(
                A<IEnumerable<int>>.That.Matches(i => i.Count() == 2 && i.Contains(1337) && i.Contains(5)),
                A<PushNotification>.That.Matches(push =>
                    push.InvitedToGame.Name              == "Robin Edbom"       &&
                    push.InvitedToGame.DurationInMinutes == 90                  &&
                    push.InvitedToGame.Place             == "Best Padel Center" &&
                    push.InvitedToGame.UnixTime          == DateTimeOffset.Parse("2020-11-07 00:00 +0000").ToUnixTimeSeconds()
                )
            )).MustHaveHappenedOnceExactly();
        }
    }
}