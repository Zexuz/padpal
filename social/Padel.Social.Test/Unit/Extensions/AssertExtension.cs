using System;
using Xunit;

namespace Padel.Social.Test.Unit.Extensions
{
    public static class AssertExtension
    {
        public static void TimeWithinDuration(DateTimeOffset expected, DateTimeOffset real, TimeSpan margin)
        {
            var diff = (real - expected).Duration();
            Assert.True(diff < margin, $"diff is higher than allowed, expected:{expected}, real:{real}, diff:{diff}, margin:{margin}");
        }
    }
}