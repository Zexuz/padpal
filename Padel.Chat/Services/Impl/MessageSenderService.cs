using System.Threading.Tasks;
using Padel.Chat.Factories;
using Padel.Chat.Models;
using Padel.Chat.Repositories;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Services.Impl
{
    public class MessageSenderService : IMessageSenderService
    {
        private readonly IRoomRepository _roomRepository;
        private readonly IMessageFactory _messageFactory;

        public MessageSenderService(
            IRoomRepository roomRepository,
            IMessageFactory messageFactory
        )
        {
            _roomRepository = roomRepository;
            _messageFactory = messageFactory;
        }

        public async Task SendMessage(UserId userId, ChatRoom room, string content)
        {
            room.Messages.Add(_messageFactory.Build(userId, content));

            await _roomRepository.ReplaceOneAsync(room);
        }
    }
}