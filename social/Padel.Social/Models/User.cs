using MongoDB.Bson;
using Padel.Repository.Core.MongoDb;

namespace Padel.Social.Models
{
    [BsonCollection("user")]
    public class User : IDocument
    {
        public ObjectId Id     { get; set; }
        public int      UserId { get; set; }
        public string   Name   { get; set; }
    }
}