using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Chat.ValueTypes;
using Padel.Repository.Core.MongoDb;

namespace Padel.Chat.Models
{
    [BsonCollection("converstation")]
    public class Conversation : IDocument
    {
        public ObjectId     Id          { get; set; }
        public UserId       UserId      { get; set; }
        public List<RoomId> MyChatRooms { get; set; }
    }
}