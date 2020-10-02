using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Grpc.Core;
using Grpc.Core.Testing;

namespace Padel.Test.Core
{
    public abstract class TestControllerBase
    {
        protected static ServerCallContext CreateServerCallContextWithUserId(int userId)
        {
            var md = new Metadata
            {
                {"padpal-user-id", userId.ToString()}
            };

            return CreateServerCallContextWithMetadata(md);
        }

        protected static ServerCallContext CreateServerCallContextWithNo()
        {
            return CreateServerCallContextWithMetadata(Metadata.Empty);
        }

        private static ServerCallContext CreateServerCallContextWithMetadata(Metadata md)
        {
            var ctx = TestServerCallContext.Create(
                "",
                "",
                DateTime.Now,
                md,
                CancellationToken.None,
                "",
                new AuthContext(
                    "",
                    new Dictionary<string, List<AuthProperty>>()
                ),
                null,
                metadata => Task.CompletedTask,
                () => WriteOptions.Default,
                options => { }
            );

            return ctx;
        }
    }
}