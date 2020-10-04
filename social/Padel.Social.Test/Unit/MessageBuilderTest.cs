using System;
using Padel.Social.Factories;
using Padel.Social.Test.Unit.Extensions;
using Padel.Social.ValueTypes;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class MessageBuilderTest
    {
        private readonly MessageFactory _sut;

        public MessageBuilderTest()
        {
            _sut = new MessageFactory();
        }


        [Fact]
        public void Build_should_build_new_message()
        {
            var author = new UserId(4);

            var message = _sut.Build(author, "myMessage");

            Assert.Equal(4, message.Author.Value);
            Assert.Equal("myMessage", message.Content);
            AssertExtension.TimeWithinDuration(message.Timestamp, DateTimeOffset.UtcNow, TimeSpan.FromSeconds(5));
        }
    }
}