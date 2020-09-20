using System.Collections.Generic;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IRoomFactory
    {
        ChatRoom NewRoom(UserId userId);
    }

    public class RoomFactory : IRoomFactory
    {
        private readonly IRoomIdGenerator _roomIdGenerator;

        public RoomFactory(IRoomIdGenerator roomIdGenerator)
        {
            _roomIdGenerator = roomIdGenerator;
        }

        public ChatRoom NewRoom(UserId userId)
        {
            return new ChatRoom
            {
                Admin = userId,
                Id = new RoomId(_roomIdGenerator.GenerateNewRoomId()),
                Messages = new List<Message>(),
                Participants = new List<UserId> {userId}
            };
        }
    }
}