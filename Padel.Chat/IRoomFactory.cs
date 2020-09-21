using System.Collections.Generic;
using MongoDB.Driver;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IRoomFactory
    {
        ChatRoom NewRoom(UserId userId, IReadOnlyList<UserId> participants);
    }

    public class RoomFactory : IRoomFactory
    {
        private readonly IRoomIdGenerator _roomIdGenerator;

        public RoomFactory(IRoomIdGenerator roomIdGenerator)
        {
            _roomIdGenerator = roomIdGenerator;
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
                RoomId = new RoomId(_roomIdGenerator.GenerateNewRoomId()),
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