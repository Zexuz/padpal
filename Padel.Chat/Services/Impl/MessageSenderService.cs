using System.Linq;
using System.Threading.Tasks;
using Padel.Chat.Factories;
using Padel.Chat.Repositories;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;
using Padel.Proto.Chat.V1;
using Padel.Queue;
using ChatRoom = Padel.Chat.Models.ChatRoom;

namespace Padel.Chat.Services.Impl
{
    public class MessageSenderService : IMessageSenderService
    {
        private readonly IRoomRepository _roomRepository;
        private readonly IMessageFactory _messageFactory;
        private readonly IPublisher      _publisher;

        public MessageSenderService(
            IRoomRepository roomRepository,
            IMessageFactory messageFactory,
            IPublisher      publisher
        )
        {
            _roomRepository = roomRepository;
            _messageFactory = messageFactory;
            _publisher = publisher;
        }

        public async Task SendMessage(UserId userId, ChatRoom room, string content)
        {
            room.Messages.Add(_messageFactory.Build(userId, content));

            await _roomRepository.ReplaceOneAsync(room);
            
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