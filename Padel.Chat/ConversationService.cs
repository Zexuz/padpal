using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.old;

namespace Padel.Chat
{
    public class ConversationService
    {
        private readonly IRepository<Conversation, int> _repository;
        private readonly IRoomService                   _roomService;

        public ConversationService(IRepository<Conversation, int> repository, IRoomService roomService)
        {
            _repository = repository;
            _roomService = roomService;
        }

        public async Task CreateRoom(string roomId, int adminUserId, string initMessage, int[] participants)
        {
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
        }
    }
}