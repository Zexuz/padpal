using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class ConversationService : IConversationService
    {
        private readonly IRoomRepository       _roomRepository;
        private readonly IRoomService          _roomService;
        private readonly IMessageSenderService _messageSenderService;

        public ConversationService(
            IRoomRepository       roomRepository,
            IRoomService          roomService,
            IMessageSenderService messageSenderService
        )
        {
            _roomRepository = roomRepository;
            _roomService = roomService;
            _messageSenderService = messageSenderService;
        }

        public async Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId)
        {
            return await _roomRepository.GetRoomsWhereUsersIsParticipant(userId);
        }

        public async Task SendMessage(UserId userId, RoomId roomId, string content)
        {
            var room = await _roomService.GetRoom(userId, roomId);
            await _messageSenderService.SendMessage(userId, room, content);
        }
    }
}