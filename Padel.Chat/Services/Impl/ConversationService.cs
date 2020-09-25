using System.Linq;
using System.Threading.Tasks;
using Padel.Chat.Events;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;
using Padel.Queue;

namespace Padel.Chat.Services.Impl
{
    public class ConversationService : IConversationService
    {
        private readonly IRoomService          _roomService;
        private readonly IMessageSenderService _messageSenderService;
        private readonly IPublisher            _publisher;

        public ConversationService(IRoomService roomService, IMessageSenderService messageSenderService, IPublisher publisher)
        {
            _roomService = roomService;
            _messageSenderService = messageSenderService;
            _publisher = publisher;
        }

        public async Task SendMessage(UserId userId, RoomId roomId, string content)
        {
            var room = await _roomService.GetRoom(userId, roomId);
            await _messageSenderService.SendMessage(userId, room, content);
         
            await _publisher.PublishMessage(new ChatMessageEvent
            {
                Content = content,
                Participants = room.Participants.Select(id => id.Value).ToList()
            });
        }
    }
}