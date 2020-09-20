using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Driver;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    public class RoomRepository : MongoRepository<ChatRoom, RoomId>, IRoomRepository
    {
        public RoomRepository(IMongoDbConnectionFactory client) : base(client)
        {
        }

        public async Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUsersIsParticipant(UserId userId)
        {
            var filter = Builders<ChatRoom>.Filter.All(room => room.Participants, new[] {userId});
            var result = await Collection.FindAsync<ChatRoom>(filter);
            return result.ToList();
        }

        public Task<ChatRoom> GetRoom(RoomId roomId)
        {
            throw new System.NotImplementedException();
        }
    }
}