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

        [Fact]
        public async Task Should_throw_if_argument_is_invalid()
        {
            var request = new AppendFcmTokenToUserRequest();
            var ctx = CreateServerCallContextWithUserId(1337);

            await Assert.ThrowsAsync<ArgumentException>(() => _sut.AppendFcmTokenToUser(request, ctx));
        }
    }
}