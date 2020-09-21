using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Chat.MongoDb;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;

namespace Padel.Chat
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