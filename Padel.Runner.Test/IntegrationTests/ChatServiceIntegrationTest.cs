using System.Threading.Tasks;
using Grpc.Core;
using Padel.Proto.Auth.V1;
using Padel.Proto.Chat.V1;
using Padel.Runner.Test.IntegrationTests.Helpers;
using Xunit;

namespace Padel.Runner.Test.IntegrationTests
{
    public class ChatServiceIntegrationTest : GrpcIntegrationTestBase, IClassFixture<CustomWebApplicationFactory<Startup>>
    {
        private readonly ChatService.ChatServiceClient _chatServiceClient;
        private readonly UserGeneratedData             _user;
        private readonly SignInResponse                 _loginResponse;
        private          Metadata                      _authHeader;

        public ChatServiceIntegrationTest(CustomWebApplicationFactory<Startup> factory) : base(factory)
        {
            var channel = factory.CreateGrpcChannel();
            _chatServiceClient = new ChatService.ChatServiceClient(channel);
            _user = UserGeneratedData.Random();
            _loginResponse = RegisterAndSignInUser(_user).GetAwaiter().GetResult();
            _authHeader = CreateAuthMetadata(_loginResponse.Token);
        }

        [Fact]
        public async Task When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoom()
        {
            var createRoomResponse = await _chatServiceClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoom",
                    Participants = {1337}
                },
                _authHeader
            );

            var getRoomResponse = await _chatServiceClient.GetRoomAsync(new GetRoomRequest {RoomId = createRoomResponse.RoomId}, _authHeader);

            Assert.Equal(createRoomResponse.RoomId, getRoomResponse.Room.Id);
            Assert.Equal(2, getRoomResponse.Room.Participants.Count);
            Assert.Single(getRoomResponse.Room.Messages);
        }

        [Fact]
        public async Task When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating()
        {
            var createRoomResponse = await _chatServiceClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating",
                    Participants = {1338}
                },
                _authHeader
            );

            var createRoomResponse1 = await _chatServiceClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating",
                    Participants = {3, 5, 6, 712}
                },
                _authHeader
            );

            var res =
                await _chatServiceClient.GetRoomsWhereUserIsParticipatingAsync(new GetRoomsWhereUserIsParticipatingRequest(), _authHeader);

            Assert.Equal(2, res.RoomIds.Count);
            Assert.Contains(createRoomResponse.RoomId, res.RoomIds);
            Assert.Contains(createRoomResponse1.RoomId, res.RoomIds);
        }
    }
}