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
        private readonly IRoomFactory                      _roomFactory;
        private readonly IRoomRepository                   _roomRepository;
        private readonly IMessageSenderService             _messageSenderService;

        public RoomService(
            IRepository<Conversation, UserId> conversationRepository,
            IRoomFactory                      roomFactory,
            IRoomRepository                   roomRepository,
            IMessageSenderService messageSenderService
        )
        {
            _conversationRepository = conversationRepository;
            _roomFactory = roomFactory;
            _roomRepository = roomRepository;
            _messageSenderService = messageSenderService;
        }

        public async Task<ChatRoom> CreateRoom(UserId adminUserId, string initMessage, IReadOnlyList<UserId> participants)
        {
            var room = _roomFactory.NewRoom(adminUserId, participants);
            await _roomRepository.SaveAsync(room);

            foreach (var participant in room.Participants)
            {
                var coon = await _conversationRepository.GetAsync(participant);

                if (coon == null)
                {
                    coon = new Conversation {Id = participant, MyChatRooms = new List<RoomId>()};
                }

                coon.MyChatRooms.Add(room.Id);

                await _conversationRepository.SaveAsync(coon);
            }

            await _messageSenderService.SendMessage(adminUserId, room, initMessage);
            return room;
        }

        public async Task<ChatRoom> GetRoom(UserId userId, RoomId roomId)
        {
            return await VerifyUsersAccessToRoom(userId, roomId);
        }

        private async Task<ChatRoom> VerifyUsersAccessToRoom(UserId userId, RoomId roomId)
        {
            var room = await _roomRepository.GetRoom(roomId);
            if (room == null) // ROOM ID is null
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