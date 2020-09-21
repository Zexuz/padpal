using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Chat.MongoDb;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
{
    [BsonCollection("converstation")]
    public class Conversation : IDocument
    {
        public ObjectId     Id          { get; set; }
        public UserId       UserId      { get; set; }
        public List<RoomId> MyChatRooms { get; set; }
    }
}