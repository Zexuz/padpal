using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Repository.Core.MongoDb;
using Padel.Social.ValueTypes;

namespace Padel.Social.Models
{
    [BsonCollection("chatRoom")]
    public class ChatRoom : IDocument
    {
        public ObjectId      Id           { get; set; }
        public RoomId        RoomId       { get; set; }
        public UserId        Admin        { get; set; }
        public List<UserId>  Participants { get; set; }
        public List<Message> Messages     { get; set; }
    }
}