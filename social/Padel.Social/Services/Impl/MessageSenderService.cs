using System.Linq;
using System.Threading.Tasks;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Padel.Social.Factories;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;
using ChatRoom = Padel.Social.Models.ChatRoom;

namespace Padel.Social.Services.Impl
{
    public class MessageSenderService : IMessageSenderService
    {
        private readonly IRoomRepository   _roomRepository;
        private readonly IMessageFactory   _messageFactory;
        private readonly IPublisher        _publisher;
        private readonly IRoomEventHandler _roomEventHandler;

        public MessageSenderService(
            IRoomRepository roomRepository,
            IMessageFactory messageFactory,
            IPublisher      publisher,
            IRoomEventHandler roomEventHandler
        )
        {
            _roomRepository = roomRepository;
            _messageFactory = messageFactory;
            _publisher = publisher;
            _roomEventHandler = roomEventHandler;
        }

        public async Task SendMessage(UserId userId, ChatRoom room, string content)
        {
            var message = _messageFactory.Build(userId, content);
            room.Messages.Add(message);

            await _roomRepository.ReplaceOneAsync(room);
            
            _roomEventHandler.EmitMessage(room.RoomId.Value, message);
            
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