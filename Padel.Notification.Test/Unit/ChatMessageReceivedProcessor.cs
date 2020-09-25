using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text.Json;
using System.Threading.Tasks;
using FakeItEasy;
using FirebaseAdmin.Messaging;
using Google.Protobuf;
using Microsoft.Extensions.Logging;
using Padel.Notification.MessageProcessors;
using Padel.Proto.Chat.V1;
using Padel.Repository.Core.MongoDb;
using Xunit;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.Test.Unit
{
    public class ChatMessageReceivedProcessorTest
    {
        private readonly ChatMessageReceivedProcessor          _sut;
        private readonly IFirebaseCloudMessaging               _fakeFirebaseCloudMessaging;
        private readonly IMongoRepository<UserNotificationSetting> _fakeRepo;
        private          ILogger<ChatMessageReceivedProcessor> logger;

        public ChatMessageReceivedProcessorTest()
        {
            logger = A.Fake<ILogger<ChatMessageReceivedProcessor>>();
            _fakeFirebaseCloudMessaging = A.Fake<IFirebaseCloudMessaging>();
            _fakeRepo = A.Fake<IMongoRepository<UserNotificationSetting>>();
            _sut = new ChatMessageReceivedProcessor(_fakeFirebaseCloudMessaging, _fakeRepo, logger);
        }


        [Theory]
        [InlineData("")]
        [InlineData("{someOther:\"json Object\"}")]
        public async Task Should_throw_error_is_message_body_is_invalid(string body)
        {
            await Assert.ThrowsAsync<InvalidJsonException>(() => _sut.ProcessAsync(new Message {Body = body}));
        }

        [Fact]
        public async Task Should_send_notification_to_users()
        {
            var message = new Message
            {
                Body = JsonSerializer.Serialize(new ChatMessageReceived
                {
                    Participants = {10, 5, 1337},
                    RoomId = "this is a roomid"
                }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase})
            };

            var findResults = new[]
            {
                new UserNotificationSetting {UserId = 10, FCMTokens = new List<string> {"a", "b"}},
                new UserNotificationSetting {UserId = 10, FCMTokens = new List<string> {"c"}},
                null,
            };

            A.CallTo(() => _fakeRepo.FindOneAsync(A<Expression<Func<UserNotificationSetting, bool>>>._)).ReturnsNextFromSequence(findResults);

            await _sut.ProcessAsync(message);

            A.CallTo(() => _fakeFirebaseCloudMessaging.SendMulticastAsync(A<MulticastMessage>.That.Matches(m =>
                m.Tokens.Count == 3
            ))).MustHaveHappenedOnceExactly();
        }
    }
}