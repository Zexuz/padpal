using System.Collections.Generic;
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

        public List<FriendRequest> FriendRequests { get; set; } = new List<FriendRequest>();
        public List<Friend>        Friends        { get; set; } = new List<Friend>();
    }

    public class Friend
    {
        public int UserId { get; set; }
    }

    public class FriendRequest
    {
        public int UserId { get; set; }
    }
}