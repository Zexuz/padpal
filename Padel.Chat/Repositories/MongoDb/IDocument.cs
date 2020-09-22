using System;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Padel.Chat.Repositories.MongoDb
{
    public interface IDocument
    {
        [BsonId]
        [BsonRepresentation(BsonType.String)]
        ObjectId Id { get; set; }

        DateTime CreatedAt => Id.CreationTime;
    }
}