using System.Threading.Tasks;
using Grpc.Core;
using Padel.Chat.Runner;
using Padel.Chat.Test.Functional.Helper;
using Padel.Proto.Chat.V1;
using Xunit;

namespace Padel.Chat.Test.Functional
{
    public class ChatServiceIntegrationTest : IClassFixture<MongoWebApplicationFactory<Startup>>
    {
        private readonly ChatService.ChatServiceClient _chatServiceClient;

        public ChatServiceIntegrationTest(MongoWebApplicationFactory<Startup> factoryBase)
        {
            var channel = factoryBase.CreateGrpcChannel();
            _chatServiceClient = new ChatService.ChatServiceClient(channel);
        }

        [Fact]
        public async Task When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoom()
        {
            var _requestHeader = new Metadata
            {
                {"padpal-user-id", "1"},
            };
            var createRoomResponse = await _chatServiceClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoom",
                    Participants = {1337}
                },
                _requestHeader
            );

            var getRoomResponse = await _chatServiceClient.GetRoomAsync(new GetRoomRequest {RoomId = createRoomResponse.RoomId}, _requestHeader);

            Assert.Equal(createRoomResponse.RoomId, getRoomResponse.Room.Id);
            Assert.Equal(2, getRoomResponse.Room.Participants.Count);
            Assert.Single(getRoomResponse.Room.Messages);
        }

        [Fact]
        public async Task When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating()
        {
            var _requestHeader = new Metadata
            {
                {"padpal-user-id", "2"},
            };
            var createRoomResponse = await _chatServiceClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating",
                    Participants = {1338}
                },
                _requestHeader
            );

            var createRoomResponse1 = await _chatServiceClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating",
                    Participants = {3, 5, 6, 712}
                },
                _requestHeader
            );

            var res =
                await _chatServiceClient.GetRoomsWhereUserIsParticipatingAsync(new GetRoomsWhereUserIsParticipatingRequest(), _requestHeader);

            Assert.Equal(2, res.RoomIds.Count);
            Assert.Contains(createRoomResponse.RoomId, res.RoomIds);
            Assert.Contains(createRoomResponse1.RoomId, res.RoomIds);
        }
    }
}