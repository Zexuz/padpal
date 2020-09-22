using System.Collections.Generic;
using Padel.Chat.Exceptions;
using Padel.Chat.Models;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Factories
{
    public class RoomFactory : IRoomFactory
    {
        private readonly IRoomIdGeneratorService _roomIdGeneratorService;

        public RoomFactory(IRoomIdGeneratorService roomIdGeneratorService)
        {
            _roomIdGeneratorService = roomIdGeneratorService;
        }

        public ChatRoom NewRoom(UserId userId, IReadOnlyList<UserId> participants)
        {
            var allParticipants = new List<UserId> {userId};
            allParticipants.AddRange(participants);

            if (TryGetDuplicate(allParticipants, out var duplicate))
            {
                throw new ParticipantAlreadyAddedException(duplicate);
            }

            return new ChatRoom
            {
                Admin = userId,
                RoomId = new RoomId(_roomIdGeneratorService.GenerateNewRoomId()),
                Messages = new List<Message>(),
                Participants = allParticipants
            };
        }

        private bool TryGetDuplicate(List<UserId> ids, out UserId duplicate)
        {
            duplicate = null;
            var hashSet = new HashSet<UserId>();

            for (var i = 0; i < ids.Count; i++)
            {
                var item = ids[i];
                if (hashSet.Contains(item))
                {
                    duplicate = item;
                    return true;
                }

                hashSet.Add(item);
            }

            return false;
        }
    }
}