using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class RoomService : IRoomService
    {
        private readonly IRepository<Conversation, UserId> _conversationRepository;
        private readonly IConversationService              _conversationService;
        private readonly IRoomFactory                      _roomFactory;
        private readonly IRoomRepository                   _roomRepository;

        public RoomService(
            IRepository<Conversation, UserId> conversationRepository,
            IConversationService              conversationService,
            IRoomFactory                      roomFactory,
            IRoomRepository                   roomRepository
        )
        {
            _conversationRepository = conversationRepository;
            _conversationService = conversationService;
            _roomFactory = roomFactory;
            _roomRepository = roomRepository;
        }

        public async Task<ChatRoom> CreateRoom(UserId adminUserId, string initMessage, IEnumerable<UserId> participants)
        {
            var room = _roomFactory.NewRoom(adminUserId);
            await _roomRepository.SaveAsync(room);

            var allParticipants = new List<UserId> {adminUserId};
            allParticipants.AddRange(participants);

            foreach (var participant in allParticipants)
            {
                var coon = await _conversationRepository.GetAsync(participant);

                if (coon == null)
                {
                    coon = new Conversation {Id = participant, MyChatRooms = new List<RoomId>()};
                }

                coon.MyChatRooms.Add(room.Id);

                await _conversationRepository.SaveAsync(coon);
            }

            await _conversationService.SendMessage(adminUserId, room.Id, initMessage);
            return room;
        }

        public async Task<ChatRoom> GetRoom(UserId userId, RoomId roomId)
        {
            return await VerifyUsersAccessToRoom(userId, roomId);
        }

        private async Task<ChatRoom> VerifyUsersAccessToRoom(UserId userId, RoomId roomId)
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

            return room;
        }
    }
}