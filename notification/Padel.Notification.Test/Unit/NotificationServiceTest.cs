using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using FakeItEasy;
using FirebaseAdmin.Messaging;
using Padel.Notification.Models;
using Padel.Notification.Repository;
using Padel.Notification.Service;
using Padel.Proto.Notification.V1;
using Padel.Test.Core;
using Xunit;

namespace Padel.Notification.Test.Unit
{
    public class NotificationServiceTest
    {
        private readonly NotificationService     _sut;
        private          IUserRepository         _fakeRepo;
        private          IFirebaseCloudMessaging _fakeFirebaseCloudMessaging;

        public NotificationServiceTest()
        {
            _fakeFirebaseCloudMessaging = A.Fake<IFirebaseCloudMessaging>();
            _fakeRepo = A.Fake<IUserRepository>();

            _sut = TestHelper.ActivateWithFakes<NotificationService>(_fakeFirebaseCloudMessaging, _fakeRepo);
        }

        [Fact]
        public async Task Should_NOT_send_notification_to_users_when_there_are_no_FCMTokens()
        {
            var userIds = new[] {1337};
            var notification = new PushNotification
            {
                UtcTimestamp = DateTimeOffset.Now.ToUnixTimeSeconds(),
                ChatMessageReceived = new PushNotification.Types.ChatMessageReceived
                {
                    RoomId = "someRoomId"
                }
            };

            A.CallTo(() => _fakeRepo.FindOneAsync(A<Expression<Func<User, bool>>>._)).Returns(Task.FromResult<User>(null));

            await _sut.AddAndSendNotification(userIds, notification);

            A.CallTo(() => _fakeFirebaseCloudMessaging.SendMulticastAsync(A<MulticastMessage>._)).MustNotHaveHappened();
            A.CallTo(() => _fakeRepo.ReplaceOneAsync(A<User>._)).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_send_notification_to_users_when_there_are_FCMTokens()
        {
            var userIds = new[] {10, 9, 8};
            var notification = new PushNotification
            {
                UtcTimestamp = DateTimeOffset.Now.ToUnixTimeSeconds(),
                ChatMessageReceived = new PushNotification.Types.ChatMessageReceived
                {
                    RoomId = "someRoomId"
                }
            };

            var findResults = new[]
            {
                new User {UserId = 10, FCMTokens = new List<string> {"a", "b"}},
                new User {UserId = 9, FCMTokens = new List<string> {"c"}},
                new User {UserId = 8},
            };

            A.CallTo(() => _fakeRepo.FindOrCreateByUserId(A<int>._)).ReturnsNextFromSequence(findResults);

            A.CallTo(() => _fakeRepo.FindOneAsync(A<Expression<Func<User, bool>>>._)).Returns(Task.FromResult<User>(null));

            await _sut.AddAndSendNotification(userIds, notification);

            A.CallTo(() => _fakeFirebaseCloudMessaging.SendMulticastAsync(A<MulticastMessage>._)).MustHaveHappened();
            A.CallTo(() => _fakeRepo.ReplaceOneAsync(A<User>._)).MustHaveHappened(3, Times.Exactly);
        }
    }
}