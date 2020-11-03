using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Repositories
{
    public interface IRoomRepository : IMongoRepository<ChatRoom>
    {
        Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUsersIsParticipant(UserId userId);
        Task<ChatRoom>                      GetRoom(RoomId                         roomId);
        Task<IReadOnlyCollection<ChatRoom>> GetConversationBetweenUsers(int        userId1, int userId2);
    }
}