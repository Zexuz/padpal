using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Chat.old;
using Xunit;

namespace Padel.Chat.Test
{
    // We could have a endpoint 'GetRoomIdForP2P(int userId):string, error', it returns error when we are not allow to chat with that person.
    // It return a roomId that than can be used to with SendMessageToRoom(roomId, message). If the roomId does not exists yet, we add it. b/c we already know that this is a valid roomid.rrrrrrrrrrrrrr 

    // Create a collection that keeps track of what conversations that you are currently participating in

    public class ConversationServiceTest
    {
        private readonly ConversationService            _sut;
        private readonly IRepository<Conversation, int> _fakeRepository;
        private readonly IRoomService                   _fakeRoomService;

        public ConversationServiceTest()
        {
            _fakeRepository = A.Fake<IRepository<Conversation, int>>();
             _fakeRoomService =  A.Fake<IRoomService>();
            _sut = new ConversationService(_fakeRepository, _fakeRoomService);
        }

        [Fact]
        public async Task CreateConversation_should_add_conversation()
        {
            const int myUserId = 4;
            var participants = new[] {5, 7, 99};
            var initMessage = "asd";

            const string roomId = "roomId"; // This will come from the backend

            A.CallTo(() => _fakeRepository.GetAsync(A<int>._)).Returns(Task.FromResult<Conversation>(null));

            await _sut.CreateRoom(roomId, myUserId, initMessage, participants);

            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 4 &&
                conversation.MyChatRooms.Exists(s => s == "roomId")
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 5 &&
                conversation.MyChatRooms.Exists(s => s == "roomId")
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 7 &&
                conversation.MyChatRooms.Exists(s => s == "roomId")
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 99 &&
                conversation.MyChatRooms.Exists(s => s == "roomId")
            ))).MustHaveHappened();

            A.CallTo(() => _fakeRoomService.SendMessage(myUserId, roomId, initMessage)).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task CreateConversation_should_append_room_if_list_already_exists()
        {
            const int myUserId = 4;
            var participants = new[] {5, 7, 99};
            var initMessage = "asd";

            const string roomId = "roomId"; // This will come from the backend
            A.CallTo(() => _fakeRepository.GetAsync(4)).Returns(new Conversation {Id = 4, MyChatRooms = new List<string> {"someRoom"}});
            A.CallTo(() => _fakeRepository.GetAsync(5)).Returns(Task.FromResult<Conversation>(null));
            A.CallTo(() => _fakeRepository.GetAsync(7)).Returns(Task.FromResult<Conversation>(null));
            A.CallTo(() => _fakeRepository.GetAsync(99)).Returns(new Conversation
                {Id = 99, MyChatRooms = new List<string> {"someOtherRoom", "anotherRoom"}});

            await _sut.CreateRoom(roomId, myUserId, initMessage, participants);

            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 4                          &&
                conversation.MyChatRooms.Contains("someRoom") &&
                conversation.MyChatRooms.Contains("roomId")   &&
                conversation.MyChatRooms.Count == 2
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 5                                &&
                conversation.MyChatRooms.Exists(s => s == "roomId") &&
                conversation.MyChatRooms.Count == 1
            ))).MustHaveHappened();
            A.CallTo(() => _fakeRepository.SaveAsync(A<Conversation>.That.Matches(conversation =>
                conversation.Id == 99                              &&
                conversation.MyChatRooms.Contains("someOtherRoom") &&
                conversation.MyChatRooms.Contains("anotherRoom")   &&
                conversation.MyChatRooms.Contains("roomId")        &&
                conversation.MyChatRooms.Count == 3
            ))).MustHaveHappened();

            A.CallTo(() => _fakeRoomService.SendMessage(myUserId, roomId, initMessage)).MustHaveHappenedOnceExactly();
        }
    }
}