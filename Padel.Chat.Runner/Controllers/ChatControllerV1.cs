using System.Linq;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;
using Padel.Grpc.Core;
using Padel.Proto.Chat.V1;

namespace Padel.Chat.Runner.Controllers
{
    public class ChatControllerV1 : ChatService.ChatServiceBase
    {
        private readonly IConversationService _conversationService;
        private readonly IRoomService         _roomService;

        public ChatControllerV1(IConversationService conversationService, IRoomService roomService)
        {
            _conversationService = conversationService;
            _roomService = roomService;
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

            await _conversationService.SendMessage(userId, new RoomId(request.RoomId), request.Content);

            return new SendMessageResponse();
        }

        public override async Task<GetRoomResponse> GetRoom(GetRoomRequest request, ServerCallContext context)
        {
            var userId = new UserId(context.GetUserId());
            var room = await _roomService.GetRoom(userId, new RoomId(request.RoomId));
            return new GetRoomResponse
            {
                Room = new Padel.Proto.Chat.V1.ChatRoom()
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
    }
}