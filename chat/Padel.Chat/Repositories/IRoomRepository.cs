using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Chat.Models;
using Padel.Chat.ValueTypes;
using Padel.Repository.Core.MongoDb;

namespace Padel.Chat.Repositories
{
    public interface IRoomRepository : IMongoRepository<ChatRoom>
    {
        Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUsersIsParticipant(UserId userId);
        Task<ChatRoom>                      GetRoom(RoomId                         roomId);
    }
}