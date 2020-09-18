using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Xunit;

namespace Padel.Chat.Test
{
    // TODO, in order
    //Send messages to a room
    //Get messages for a room (Stream)

    //Get messages history for a room
    //Update when a participant (meself) was last seen active in chat. (Read status)

    public class ChatServiceTest
    {
        private readonly ChatService _sut;

        public ChatServiceTest()
        {
            _sut = new ChatService();
        }

        [Fact]
        public async Task SendMessage_should_raise_event()
        {
            var author = 1;

            var receivedMessages = new List<MessageReceivedEventArgs>();

            _sut.MessageReceived += (sender, args) => { receivedMessages.Add(args); };

            await _sut.SendMessage(author, "some text message");
            await _sut.SendMessage(author, "some other text message");
            await _sut.SendMessage(author, "some different text message");

            var messages = receivedMessages;
            Assert.Equal(3, messages.Count);
            Assert.Equal("some text message", messages[0].Message.Content);
            AssertExtension.TimeWithinDuration(messages[0].Message.Timestamp, DateTimeOffset.UtcNow, TimeSpan.FromSeconds(10));
        }


        [Fact]
        public async Task SendMessage_should_add_message_to_room()
        {
            var author = 1;

            Assert.Equal(0, _sut.GetMessages().Count);

            await _sut.SendMessage(author, "some text message");

            var messages = _sut.GetMessages();

            Assert.Equal(1, messages.Count);
            Assert.Equal("some text message", messages[0].Content);
            AssertExtension.TimeWithinDuration(messages[0].Timestamp, DateTimeOffset.UtcNow, TimeSpan.FromSeconds(10));
        }
    }
}