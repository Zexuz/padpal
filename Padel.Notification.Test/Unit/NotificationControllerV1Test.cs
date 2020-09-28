using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using FakeItEasy;
using Grpc.Core;
using Padel.Notification.Runner.Controllers;
using Padel.Proto.Notification.V1;
using Padel.Repository.Core.MongoDb;
using Padel.Test.Core;
using Xunit;

namespace Padel.Notification.Test.Unit
{
    public class NotificationControllerV1Test : TestControllerBase
    {
        private readonly NotificationControllerV1                       _sut;
        private readonly IMongoRepository<UserNotificationSetting> _fakeMongoRepo;

        public NotificationControllerV1Test()
        {
            _fakeMongoRepo = A.Fake<IMongoRepository<UserNotificationSetting>>();
            _sut = new NotificationControllerV1(_fakeMongoRepo);
        }

        // TODO Save the FCMToken and subscribe to topics!

        // Can we use middlewares here? One that is called "SetUpService" that set us the aws queue and topic subscription

        [Fact]
        public async Task Should_throw_if_argument_is_invalid()
        {
            var request = new AppendFcmTokenToUserRequest();
            var ctx = CreateServerCallContextWithUserId(1337);

            var ex = await Assert.ThrowsAsync<RpcException>(() => _sut.AppendFcmTokenToUser(request, ctx));
            Assert.Equal(StatusCode.InvalidArgument, ex.StatusCode);
        }

        [Fact]
        public async Task Should_create_new_item_if_one_does_not_already_exists()
        {
            var userId = 2;
            var ctx = CreateServerCallContextWithUserId(userId);
            var request = new AppendFcmTokenToUserRequest
            {
                FcmToken = "myFCMToken"
            };

            A.CallTo(() => _fakeMongoRepo.FindOneAsync(A<Expression<Func<UserNotificationSetting, bool>>>._))
                .Returns(Task.FromResult<UserNotificationSetting>(null));

            await _sut.AppendFcmTokenToUser(request, ctx);

            A.CallTo(() => _fakeMongoRepo.InsertOneAsync(A<UserNotificationSetting>.That.Matches(model =>
                model.UserId          == 2 &&
                model.FCMTokens.Count == 1 &&
                model.FCMTokens[0]    == "myFCMToken"
            ))).MustHaveHappened();
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

            A.CallTo(() => _fakeMongoRepo.FindOneAsync(A<Expression<Func<UserNotificationSetting, bool>>>._)).Returns(
                new UserNotificationSetting
                {
                    UserId = 2,
                    FCMTokens = new List<string> {"myOldToken"}
                });

            await _sut.AppendFcmTokenToUser(request, ctx);

            A.CallTo(() => _fakeMongoRepo.ReplaceOneAsync(A<UserNotificationSetting>.That.Matches(model =>
                model.UserId          == 2 &&
                model.FCMTokens.Count == 2 &&
                model.FCMTokens[0]    == "myOldToken" &&
                model.FCMTokens[1]    == "myFCMToken"
            ))).MustHaveHappened();
        }
    }
}