using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Repository.Core.MongoDb;
using Padel.Social.ValueTypes;

namespace Padel.Social.Models
{
    [BsonCollection("converstation")]
    public class Conversation : IDocument
    {
        public ObjectId     Id          { get; set; }
        public UserId       UserId      { get; set; }
        public List<RoomId> MyChatRooms { get; set; }
    }
}