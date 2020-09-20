using FakeItEasy;
using Padel.Chat.old;
using Xunit;

namespace Padel.Chat.Test
{
    public class ChatRoomManagerTest
    {
        private readonly ChatRoomNofifier _sut;

        public ChatRoomManagerTest()
        {
            _sut = new ChatRoomNofifier();
        }


        [Fact]
        public void Add_should_add_user_to_room()
        {
            const string roomId = "myRoomId";

            var fakeMessageWriter = A.Fake<IMessageWriter>();

            _sut.AddListener(roomId, fakeMessageWriter);
            
            _sut.SendMessageToRoom(roomId, "my message");

            A.CallTo(() => fakeMessageWriter.Write("my message")).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public void SendMessageToRoom_should_only_send_to_that_room()
        {
            var fakeMessageWriter = A.Fake<IMessageWriter>();
            var fakeMessageWriter1 = A.Fake<IMessageWriter>();

            _sut.AddListener("SomeOtherRoom", fakeMessageWriter);
            _sut.AddListener("myRoomId", fakeMessageWriter1);
            
            _sut.SendMessageToRoom("myRoomId", "my message");

            A.CallTo(() => fakeMessageWriter.Write(A<string>._)).MustNotHaveHappened();
            A.CallTo(() => fakeMessageWriter1.Write("my message")).MustHaveHappenedOnceExactly();
        }
    }
}