﻿using System.Linq;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Proto.Social.V1;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;

namespace Padel.Social.Runner.Controllers
{
    public class SocialControllerV1 : Proto.Social.V1.Social.SocialBase
    {
        private readonly IMessageSenderService _messageSenderService;
        private readonly IRoomService          _roomService;
        private readonly IProfileSearchService _profileSearchService;
        private readonly IFriendRequestService _friendRequestService;

        public SocialControllerV1
        (
            IMessageSenderService messageSenderService,
            IRoomService          roomService,
            IProfileSearchService profileSearchService,
            IFriendRequestService friendRequestService
        )
        {
            _messageSenderService = messageSenderService;
            _roomService = roomService;
            _profileSearchService = profileSearchService;
            _friendRequestService = friendRequestService;
        }

        public override async Task<CreateRoomResponse> CreateRoom(CreateRoomRequest request, ServerCallContext context)
        {
            var userId = new UserId(context.GetUserId());

            var room = await _roomService.CreateRoom(userId, request.Content, request.Participants.Select(i => new UserId(i)).ToList());

            return new CreateRoomResponse {RoomId = room.RoomId.Value};
        }

        public override async Task<SendMessageResponse> SendMessage(SendMessageRequest request, ServerCallContext context)
        {
            var userId = new UserId(context.GetUserId());

            var room = await _roomService.GetRoom(userId, new RoomId(request.RoomId));
            await _messageSenderService.SendMessage(userId, room, request.Content);

            return new SendMessageResponse();
        }

        public override async Task<GetRoomResponse> GetRoom(GetRoomRequest request, ServerCallContext context)
        {
            var userId = new UserId(context.GetUserId());
            var room = await _roomService.GetRoom(userId, new RoomId(request.RoomId));
            return new GetRoomResponse
            {
                Room = new ChatRoom()
                {
                    Admin = room.Admin.Value,
                    Id = room.RoomId.Value,
                    Messages =
                    {
                        room.Messages.Select(message => new Message
                            {
                                Author = message.Author.Value,
                                Content = message.Content,
                                UtcTimestamp = message.Timestamp.ToUnixTimeSeconds()
                            }
                        )
                    },
                    Participants = {room.Participants.Select(id => id.Value)}
                }
            };
        }

        public override async Task<GetRoomsWhereUserIsParticipatingResponse> GetRoomsWhereUserIsParticipating(
            GetRoomsWhereUserIsParticipatingRequest request, ServerCallContext context)
        {
            var userId = new UserId(context.GetUserId());

            var rooms = await _roomService.GetRoomsWhereUserIsParticipant(userId);

            var response = new GetRoomsWhereUserIsParticipatingResponse();
            response.RoomIds.AddRange(rooms.Select(room => room.RoomId.Value));
            return response;
        }

        public override async Task<SearchForProfileResponse> SearchForProfile(SearchForProfileRequest request, ServerCallContext context)
        {
            if (string.IsNullOrWhiteSpace(request.SearchTerm))
            {
                return new SearchForProfileResponse();
            }

            var term = request.SearchTerm.Trim();
            if (term.Length < 3)
            {
                return new SearchForProfileResponse();
            }

            var profiles = await _profileSearchService.Search(term);
            return new SearchForProfileResponse
            {
                Profiles =
                {
                    profiles.Select(user => new Profile
                    {
                        Name = user.Name
                    })
                }
            };
        }

        public override async Task<SendFriendRequestResponse> SendFriendRequest(SendFriendRequestRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();
            await _friendRequestService.SendFriendRequest(userId, request.UserId);
            return new SendFriendRequestResponse();
        }

        public override async Task<RespondToFriendRequestResponse> RespondToFriendRequest(RespondToFriendRequestRequest request,
            ServerCallContext                                                                                           context)
        {
            var userId = context.GetUserId();
            await _friendRequestService.RespondToFriendRequest(userId, request.UserId, request.Action);
            return new RespondToFriendRequestResponse();
        }
    }
}