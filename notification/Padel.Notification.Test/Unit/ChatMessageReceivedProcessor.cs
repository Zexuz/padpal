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
using Padel.Notification.Models;
using Padel.Notification.Repository;
using Padel.Proto.Notification.V1;
using Padel.Proto.Social.V1;
using Padel.Repository.Core.MongoDb;
using Padel.Test.Core;
using Xunit;
using Action = System.Action;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.Test.Unit
{
    public class ChatMessageReceivedProcessorTest
    {
        private readonly ChatMessageReceivedProcessor _sut;
        private readonly IFirebaseCloudMessaging      _fakeFirebaseCloudMessaging;
        private readonly IUserRepository              _fakeRepo;

        public ChatMessageReceivedProcessorTest()
        {
            _fakeFirebaseCloudMessaging = A.Fake<IFirebaseCloudMessaging>();
            _fakeRepo = A.Fake<IUserRepository>();

            _sut = TestHelper.ActivateWithFakes<ChatMessageReceivedProcessor>(_fakeFirebaseCloudMessaging, _fakeRepo);
        }

        [Theory]
        [InlineData("")]
        [InlineData("{someOther:\"json Object\"}")]
        public async Task Should_throw_error_is_message_body_is_invalid(string body)
        {
            await Assert.ThrowsAsync<InvalidJsonException>(() => _sut.ProcessAsync(new Message {Body = body}));
        }

        [Fact]
        public async Task Should_insert_new_user_if_one_does_not_already_exists()
        {
            var message = new Message
            {
                Body = JsonSerializer.Serialize(new ChatMessageReceived
                {
                    Participants = {10, 1337},
                    RoomId = "this is a roomid"
                }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase})
            };

            var findResults = new User[]
            {
                null,
                new User
                {
                    UserId = 1337, FCMTokens = new List<string> {"token1"}, Notifications = new List<PushNotification>
                    {
                        new PushNotification
                        {
                            ChatMessageReceived = new PushNotification.Types.ChatMessageReceived()
                        }
                    }
                },
            };

            A.CallTo(() => _fakeRepo.FindByUserId(A<int>._)).ReturnsNextFromSequence(findResults);

            await _sut.ProcessAsync(message);

            A.CallTo(() => _fakeRepo.InsertOneAsync(A<User>.That.Matches(user =>
                    user.UserId                                      == 10 &&
                    user.FCMTokens.Count                             == 0  &&
                    user.Notifications.Count                         == 1  &&
                    user.Notifications[0].ChatMessageReceived.RoomId == "this is a roomid"
                )
            )).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeRepo.ReplaceOneAsync(A<User>.That.Matches(user =>
                    user.UserId                                      == 1337 &&
                    user.FCMTokens.Count                             == 1    &&
                    user.Notifications.Count                         == 2    &&
                    user.Notifications[1].ChatMessageReceived.RoomId == "this is a roomid"
                )
            )).MustHaveHappenedOnceExactly();
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
                new User {UserId = 10, FCMTokens = new List<string> {"a", "b"}},
                new User {UserId = 10, FCMTokens = new List<string> {"c"}},
                null,
            };

            A.CallTo(() => _fakeRepo.FindByUserId(A<int>._)).ReturnsNextFromSequence(findResults);

            await _sut.ProcessAsync(message);

            A.CallTo(() => _fakeFirebaseCloudMessaging.SendMulticastAsync(A<MulticastMessage>.That.Matches(m =>
                m.Tokens.Count == 3
            ))).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_NOT_send_notification_to_users_when_there_are_no_FCMTokens()
        {
            var message = new Message
            {
                Body = JsonSerializer.Serialize(new ChatMessageReceived
                {
                    Participants = {10, 5, 1337},
                    RoomId = "this is a roomid"
                }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase})
            };

            A.CallTo(() => _fakeRepo.FindOneAsync(A<Expression<Func<User, bool>>>._))
                .Returns(Task.FromResult<User>(null));

            await _sut.ProcessAsync(message);

            A.CallTo(() => _fakeFirebaseCloudMessaging.SendMulticastAsync(A<MulticastMessage>._)).MustNotHaveHappened();
        }
    }
}