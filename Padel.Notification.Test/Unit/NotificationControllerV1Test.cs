using System;
using System.Threading.Tasks;
using Padel.Notification.Runner.Controllers;
using Padel.Proto.Notification.V1;
using Padel.Test.Core;
using Xunit;

namespace Padel.Notification.Test.Unit
{
    public class NotificationControllerV1Test : TestControllerBase
    {
        private readonly NotificationControllerV1 _sut;

        public NotificationControllerV1Test()
        {
            _sut = new NotificationControllerV1();
        }
        
        // TODO Save the FCMToken and subscribe to topics!
        
        // Can we use middlewares here? One that is called "SetUpService" that set us the aws queue and topic subscription

        [Fact]
        public async Task Should_throw_if_argument_is_invalid()
        {
            var request = new AppendFcmTokenToUserRequest();
            var ctx = CreateServerCallContextWithUserId(1337);

            await Assert.ThrowsAsync<ArgumentException>(() => _sut.AppendFcmTokenToUser(request, ctx));
        }
    }
}