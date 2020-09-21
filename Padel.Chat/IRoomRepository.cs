using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.MongoDb;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public interface IRoomRepository : IMongoRepository<ChatRoom>
    {
        Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUsersIsParticipant(UserId userId);
        Task<ChatRoom>                      GetRoom(RoomId                         roomId);
    }
}