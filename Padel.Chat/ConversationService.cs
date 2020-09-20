using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class ConversationService : IConversationService
    {
        private readonly IRoomRepository _roomRepository;
        private readonly IMessageFactory _messageFactory;
        private readonly IRoomService  _roomService;

        public ConversationService(
            IRoomRepository roomRepository,
            IMessageFactory messageFactory,
            IRoomService roomService
        )
        {
            _roomRepository = roomRepository;
            _messageFactory = messageFactory;
            _roomService = roomService;
        }

        public async Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId)
        {
            return await _roomRepository.GetRoomsWhereUsersIsParticipant(userId);
        }

        public async Task SendMessage(UserId userId, RoomId roomId, string content)
        {
            var room = await _roomService.GetRoom(userId, roomId);

            room.Messages.Add(_messageFactory.Build(userId, content));

            await _roomRepository.SaveAsync(room);
        }
    }
}