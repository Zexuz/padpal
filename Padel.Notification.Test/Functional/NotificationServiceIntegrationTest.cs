using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Notification.Runner;
using Padel.Notification.Test.Functional.Helpers;
using Padel.Proto.Notification.V1;
using Padel.Queue;
using Xunit;

namespace Padel.Notification.Test.Functional
{
    public class NotificationServiceIntegrationTest : IClassFixture<MongoWebApplicationFactory<Startup>>
    {
        private Proto.Notification.V1.Notification.NotificationClient _notificationClient;

        public NotificationServiceIntegrationTest(MongoWebApplicationFactory<Startup> factory)
        {
            var fakePublisher = A.Fake<IPublisher>();
            var fakeConsumer = A.Fake<IConsumerService>();
            var fakeSubscriptionService = A.Fake<ISubscriptionService>();

            var overrides = new Dictionary<object, Type>
            {
                {fakePublisher, typeof(IPublisher)},
                {fakeConsumer, typeof(IConsumerService)},
                {fakeSubscriptionService, typeof(ISubscriptionService)},
            };

            var channel = factory.CreateGrpcChannel(overrides);
            _notificationClient = new Proto.Notification.V1.Notification.NotificationClient(channel);
        }

        [Theory]
        [InlineData("")]
        public async Task AppendFcmTokenToUserThrowsExceptionWhenFmcTokenIsInvalid(string token)
        {
            var headers = new Metadata {{Constants.UserIdHeaderKey, "1"}};
            var request = new AppendFcmTokenToUserRequest {FcmToken = token};

            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _notificationClient.AppendFcmTokenToUserAsync(request, headers));
            Assert.Equal(StatusCode.InvalidArgument, ex.StatusCode);
        }

        [Fact]
        public async Task AppendFcmTokenToUserThrowsExceptionWhenHeaderIsNotSet()
        {
            var request = new AppendFcmTokenToUserRequest {FcmToken = "some token"};
            var ex = await Assert.ThrowsAsync<RpcException>(async () => await _notificationClient.AppendFcmTokenToUserAsync(request));
            Assert.Equal(StatusCode.Unauthenticated, ex.StatusCode);
        }
    }
}