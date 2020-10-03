using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FakeItEasy;
using Grpc.Core;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Padel.Social.Runner;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Functional
{
    public class SocialServiceIntegrationTest : IClassFixture<MongoWebApplicationFactory<Startup>>
    {
        private readonly Proto.Social.V1.Social.SocialClient _socialClient;

        public SocialServiceIntegrationTest(MongoWebApplicationFactory<Startup> factoryBase)
        {
            var overrides = new Dictionary<object, Type>
            {
                {A.Fake<IPublisher>(), typeof(IPublisher)},
                {A.Fake<IConsumerService>(), typeof(IConsumerService)},
                {A.Fake<ISubscriptionService>(), typeof(ISubscriptionService)},
            };

            var channel = factoryBase.CreateGrpcChannel(overrides);
            _socialClient = new Proto.Social.V1.Social.SocialClient(channel);
        }

        [Fact]
        public async Task When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoom()
        {
            var _requestHeader = new Metadata
            {
                {"padpal-user-id", "1"},
            };
            var createRoomResponse = await _socialClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoom",
                    Participants = {1337}
                },
                _requestHeader
            );

            var getRoomResponse = await _socialClient.GetRoomAsync(new GetRoomRequest {RoomId = createRoomResponse.RoomId}, _requestHeader);

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
            var createRoomResponse = await _socialClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating",
                    Participants = {1338}
                },
                _requestHeader
            );

            var createRoomResponse1 = await _socialClient.CreateRoomAsync(new CreateRoomRequest
                {
                    Content = "When_user_creates_a_room_it_should_be_able_to_see_that_room_in_GetRoomsWhereUserIsParticipating",
                    Participants = {3, 5, 6, 712}
                },
                _requestHeader
            );

            var res =
                await _socialClient.GetRoomsWhereUserIsParticipatingAsync(new GetRoomsWhereUserIsParticipatingRequest(), _requestHeader);

            Assert.Equal(2, res.RoomIds.Count);
            Assert.Contains(createRoomResponse.RoomId, res.RoomIds);
            Assert.Contains(createRoomResponse1.RoomId, res.RoomIds);
        }
    }
}