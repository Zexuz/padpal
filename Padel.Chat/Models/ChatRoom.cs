using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Chat.Repositories.MongoDb;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Models
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