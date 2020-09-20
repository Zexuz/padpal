using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class ConversationService : IConversationService
    {
        private readonly IRepository<Conversation, int> _repository;
        private readonly IRoomService                   _roomService;
        private readonly IRoomFactory                   _roomFactory;
        private readonly IRoomRepository                _roomRepository;
        private readonly IMessageFactory                _messageFactory;

        public ConversationService(
            IRepository<Conversation, int> repository,
            IRoomService                   roomService,
            IRoomFactory                   roomFactory,
            IRoomRepository                roomRepository,
            IMessageFactory                messageFactory
        )
        {
            _repository = repository;
            _roomService = roomService;
            _roomFactory = roomFactory;
            _roomRepository = roomRepository;
            _messageFactory = messageFactory;
        }

        public async Task<ChatRoom> CreateRoom(int adminUserId, string initMessage, IEnumerable<int> participants)
        {
            var room = _roomFactory.NewRoom();
            await _roomRepository.SaveAsync(room);

            var allParticipants = new List<int> {adminUserId};
            allParticipants.AddRange(participants);

            foreach (var participant in allParticipants)
            {
                var coon = await _repository.GetAsync(participant);

                if (coon == null)
                {
                    coon = new Conversation {Id = participant, MyChatRooms = new List<RoomId>()};
                }

                coon.MyChatRooms.Add(room.Id);

                await _repository.SaveAsync(coon);
            }

            await _roomService.SendMessage(adminUserId, room.Id, initMessage);
            return room;
        }

        public async Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId)
        {
            return await _roomRepository.GetRoomsWhereUsersIsParticipant(userId);
        }

        public async Task SendMessage(UserId userId, RoomId roomId, string content)
        {
            var room = await _roomRepository.GetRoom(roomId);
            if (room == null)
            {
                throw new RoomNotFoundException(roomId);
            }

            if (room.Participants.All(id => id.Value != userId.Value))
            {
                throw new UserIsNotARoomParticipantException(userId);
            }

            // TODO Convert to list
            var messagesCopy = new Message[room.Messages.Length + 1];

            for (int i = 0; i < room.Messages.Length; i++)
            {
                messagesCopy[i] = room.Messages[i];
            }

            messagesCopy[room.Messages.Length] = _messageFactory.Build(userId, content);

            room.Messages = messagesCopy;
            await _roomRepository.SaveAsync(room);
        }
    }
}