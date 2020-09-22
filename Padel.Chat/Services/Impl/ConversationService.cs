using System.Threading.Tasks;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Services.Impl
{
    public class ConversationService : IConversationService
    {
        private readonly IRoomService          _roomService;
        private readonly IMessageSenderService _messageSenderService;

        public ConversationService(
            IRoomService          roomService,
            IMessageSenderService messageSenderService
        )
        {
            _roomService = roomService;
            _messageSenderService = messageSenderService;
        }

        public async Task SendMessage(UserId userId, RoomId roomId, string content)
        {
            var room = await _roomService.GetRoom(userId, roomId);
            await _messageSenderService.SendMessage(userId, room, content);
        }
    }
}