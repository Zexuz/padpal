using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Padel.Chat.Models;
using Padel.Chat.ValueTypes;
using Padel.Repository.Core.MongoDb;

namespace Padel.Chat.Repositories
{
    public class RoomRepository : MongoRepository<ChatRoom>, IRoomRepository
    {
        public RoomRepository(IMongoDbSettings settings) : base(settings)
        {
        }

        public async Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUsersIsParticipant(UserId userId)
        {
            var result = FilterBy(room => room.Participants.Contains(userId));
            return result.ToList();
        }

        public async Task<ChatRoom> GetRoom(RoomId roomId)
        {
            return await FindOneAsync(room => Equals(room.RoomId, roomId));
        }
    }
}