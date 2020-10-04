using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Repositories
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