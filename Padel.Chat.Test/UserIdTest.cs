using Padel.Chat.old;
using Padel.Chat.ValueTypes;
using Xunit;

namespace Padel.Chat.Test
{
    public class UserIdTest
    {
        [Theory]
        [InlineData(0)]
        [InlineData(-1)]
        [InlineData(-99999999)]
        public void IsValid_should_return_false(int userId)
        {
            Assert.False(new UserId(userId).IsValid());
        }

        [Theory]
        [InlineData(1)]
        [InlineData(120)]
        [InlineData(989789465)]
        public void IsValid_should_return_true(int userId)
        {
            Assert.True(new UserId(userId).IsValid());
        }
    }
}