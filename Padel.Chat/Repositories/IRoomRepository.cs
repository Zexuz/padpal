using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.Models;
using Padel.Chat.Repositories.MongoDb;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Repositories
{
    public interface IRoomRepository : IMongoRepository<ChatRoom>
    {
        Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUsersIsParticipant(UserId userId);
        Task<ChatRoom>                      GetRoom(RoomId                         roomId);
    }
}