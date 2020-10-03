using MongoDB.Bson;
using Padel.Repository.Core.MongoDb;

namespace Padel.Social.Models
{
    [BsonCollection("profile")]
    public class Profile : IDocument
    {
        public ObjectId Id     { get; set; }
        public int      UserId { get; set; }
        public string   Name   { get; set; }
    }
}