using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.old;

namespace Padel.Chat
{
    public class ConversationService
    {
        private readonly IRepository<Conversation, int> _repository;
        private readonly IRoomService                   _roomService;
        private readonly IRoomFactory                   _roomFactory;
        private readonly IRepository<ChatRoom, RoomId>  _roomRepository;

        public ConversationService(
            IRepository<Conversation, int> repository,
            IRoomService                   roomService,
            IRoomFactory                   roomFactory,
            IRepository<ChatRoom, RoomId>  roomRepository
        )
        {
            _repository = repository;
            _roomService = roomService;
            _roomFactory = roomFactory;
            _roomRepository = roomRepository;
        }

        public async Task<ChatRoom> CreateRoom(int adminUserId, string initMessage, int[] participants)
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
    }
}