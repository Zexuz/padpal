using System;
using Grpc.Core;

namespace Padel.Runner.Extensions
{
    public static class ServerCallContextExtension
    {
        // https://github.com/grpc/grpc-dotnet/blob/ef77760676ce19c279d5480bca68af3ea4d60e96/src/Grpc.AspNetCore.Server/Internal/HttpContextServerCallContext.cs
        public static string GetIpV4FromPeer(this ServerCallContext context)
        {
            if (!context.Peer.Contains("ipv4"))
            {
                throw new Exception("peer is not ipv4 address");
            }
            
            return context.Peer.Split(':')[1];
        }
    }
}