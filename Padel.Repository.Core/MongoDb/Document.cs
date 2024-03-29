using System;
using MongoDB.Bson;

namespace Padel.Repository.Core.MongoDb
{
    // Mongodb handles DateTime as UTC
    public abstract class Document : IDocument
    {
        public ObjectId Id        { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}