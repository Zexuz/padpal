using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.old;
using Padel.Chat.Test;

namespace Padel.Chat
{
    public class ConversationService
    {
        private readonly IRepository<Conversation, int> _repository;
        private readonly IRoomService                   _roomService;
        private readonly IRoomIdGenerator               _roomIdGenerator;

        public ConversationService(IRepository<Conversation, int> repository, IRoomService roomService, IRoomIdGenerator roomIdGenerator)
        {
            _repository = repository;
            _roomService = roomService;
            _roomIdGenerator = roomIdGenerator;
        }

        public async Task<string> CreateRoom(int adminUserId, string initMessage, int[] participants)
        {
            var roomId = _roomIdGenerator.GenerateNewRoomId();
            // TODO Here we should generate a new room
            
            var allParticipants = new List<int> {adminUserId};
            allParticipants.AddRange(participants);

            foreach (var participant in allParticipants)
            {
                var coon = await _repository.GetAsync(participant);

                if (coon == null)
                {
                    coon = new Conversation {Id = participant, MyChatRooms = new List<string>()};
                }

                coon.MyChatRooms.Add(roomId);

                await _repository.SaveAsync(coon);
            }

            await _roomService.SendMessage(adminUserId, roomId, initMessage);
            return roomId;
        }
    }
}