using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using FakeItEasy;
using Grpc.Core;
using Padel.Notification.Models;
using Padel.Notification.Repository;
using Padel.Notification.Runner.Controllers;
using Padel.Proto.Notification.V1;
using Padel.Test.Core;
using Xunit;

namespace Padel.Notification.Test.Unit
{
    public class NotificationControllerV1Test : TestControllerBase
    {
        private readonly NotificationControllerV1 _sut;
        private readonly IUserRepository          _fakeUserRepository;

        public NotificationControllerV1Test()
        {
            _fakeUserRepository = A.Fake<IUserRepository>();

            _sut = TestHelper.ActivateWithFakes<NotificationControllerV1>(_fakeUserRepository);
        }

        [Fact]
        public async Task Should_throw_if_argument_is_invalid()
        {
            var request = new AppendFcmTokenToUserRequest();
            var ctx = CreateServerCallContextWithUserId(1337);

            var ex = await Assert.ThrowsAsync<RpcException>(() => _sut.AppendFcmTokenToUser(request, ctx));
            Assert.Equal(StatusCode.InvalidArgument, ex.StatusCode);
        }

        [Fact]
        public async Task Should_append_to_item_if_one_already_exists()
        {
            var userId = 2;
            var ctx = CreateServerCallContextWithUserId(userId);
            var request = new AppendFcmTokenToUserRequest
            {
                FcmToken = "myFCMToken"
            };

            A.CallTo(() => _fakeUserRepository.FindOrCreateByUserId(2)).Returns(
                new User
                {
                    UserId = 2,
                    FCMTokens = new List<string> {"myOldToken"}
                });

            await _sut.AppendFcmTokenToUser(request, ctx);

            A.CallTo(() => _fakeUserRepository.ReplaceOneAsync(A<User>.That.Matches(model =>
                model.UserId          == 2            &&
                model.FCMTokens.Count == 2            &&
                model.FCMTokens[0]    == "myOldToken" &&
                model.FCMTokens[1]    == "myFCMToken"
            ))).MustHaveHappened();
        }

        [Fact]
        public async Task Should_not_add_duplicates()
        {
            var userId = 2;
            var ctx = CreateServerCallContextWithUserId(userId);
            var request = new AppendFcmTokenToUserRequest
            {
                FcmToken = "myFCMToken"
            };

            A.CallTo(() => _fakeUserRepository.FindOrCreateByUserId(userId)).Returns(
                new User
                {
                    UserId = 2,
                    FCMTokens = new List<string> {"myFCMToken"}
                });

            await _sut.AppendFcmTokenToUser(request, ctx);

            A.CallTo(() => _fakeUserRepository.ReplaceOneAsync(A<User>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_return_notifications()
        {
            var ctx = CreateServerCallContextWithUserId(2);
            var user = new User
            {
                Notifications = new List<PushNotification>
                {
                    new PushNotification
                    {
                        ChatMessageReceived = new PushNotification.Types.ChatMessageReceived
                        {
                            RoomId = "someRoomId"
                        }
                    },
                    new PushNotification
                    {
                        ChatMessageReceived = new PushNotification.Types.ChatMessageReceived
                        {
                            RoomId = "someOtherRoomId"
                        }
                    }
                }
            };
            A.CallTo(() => _fakeUserRepository.FindByUserId(A<int>._)).Returns(user);

            var res = await _sut.GetNotification(new GetNotificationRequest(), ctx);

            Assert.Equal(2, res.Notifications.Count);
            Assert.Equal("someRoomId", res.Notifications[0].ChatMessageReceived.RoomId);
    }
        
        [Fact]
        public async Task Should_return_no_notification_is_user_does_not_exists()
        {
            var ctx = CreateServerCallContextWithUserId(2);
            
            A.CallTo(() => _fakeUserRepository.FindByUserId(A<int>._)).Returns(null);

            var res = await _sut.GetNotification(new GetNotificationRequest(), ctx);

            Assert.Empty(res.Notifications);
        }
    }
}