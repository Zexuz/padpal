using System.Linq;
using System.Threading.Tasks;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;
using Padel.Proto.Chat.V1;
using Padel.Queue;

namespace Padel.Chat.Services.Impl
{
    public class ConversationService : IConversationService
    {
        private readonly IRoomService          _roomService;
        private readonly IMessageSenderService _messageSenderService;
        private readonly IPublisher            _publisher;

        // TODO THIS Serice seems uneccecary. why not just use "IMessageSenderSevice"?
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

            await _publisher.PublishMessage(
                new ChatMessageReceived()
                {
                    RoomId = room.RoomId.Value,
                    Participants =
                    {
                        room.Participants.Select(id => id.Value).ToList()
                    }
                }
            );
        }
    }
}