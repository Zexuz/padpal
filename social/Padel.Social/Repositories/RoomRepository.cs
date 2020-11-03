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
            var rooms = new List<ChatRoom>();
            var filter = new MongoDB.Driver.FilterDefinitionBuilder<ChatRoom>()
                .ElemMatch(profile => profile.Participants, p => p.UserId.Value == userId.Value);

            var cursor = (await _collection.FindAsync<ChatRoom>(filter));
            while (await cursor.MoveNextAsync())
            {
                rooms.AddRange(cursor.Current);
            }

            return rooms.ToList();
        }

        public async Task<ChatRoom> GetRoom(RoomId roomId)
        {
            return await FindOneAsync(room => Equals(room.RoomId, roomId));
        }

        public async Task<IReadOnlyCollection<ChatRoom>> GetConversationBetweenUsers(int userId1, int userId2)
        {
            var rooms = new List<ChatRoom>();
            var filter = new MongoDB.Driver.FilterDefinitionBuilder<ChatRoom>()
                             .ElemMatch(profile => profile.Participants, p => p.UserId.Value == userId1)
                         & new MongoDB.Driver.FilterDefinitionBuilder<ChatRoom>()
                             .ElemMatch(profile => profile.Participants, p => p.UserId.Value == userId2);

            var cursor = (await _collection.FindAsync<ChatRoom>(filter));
            while (await cursor.MoveNextAsync())
            {
                rooms.AddRange(cursor.Current);
            }

            return rooms.ToList();
        }
    }
}