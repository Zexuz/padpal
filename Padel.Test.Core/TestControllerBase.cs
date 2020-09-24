using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;
using Grpc.Core;
using Grpc.Core.Testing;
using Microsoft.AspNetCore.Http;

namespace Padel.Test.Core
{
    public abstract class TestControllerBase
    {
        protected static ServerCallContext CreateServerCallContextWithUserId(int userId)
        {
            var ctx = TestServerCallContext.Create(
                "",
                "",
                DateTime.Now,
                Metadata.Empty,
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

            var httpContext = new DefaultHttpContext();
            var claimsPrincipal = new ClaimsPrincipal();
            claimsPrincipal.AddIdentity(new ClaimsIdentity(new Claim[] {new Claim(ClaimTypes.NameIdentifier, userId.ToString())}));
            httpContext.User = claimsPrincipal;

            ctx.UserState["__HttpContext"] = httpContext;
            return ctx;
        }
    }
}