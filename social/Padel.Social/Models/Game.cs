using System;
using MongoDB.Bson;
using Padel.Proto.Game.V1;
using Padel.Repository.Core.MongoDb;

namespace Padel.Social.Models
{
    [BsonCollection("game")]
    public class Game : IDocument
    {
        public ObjectId       Id                    { get; set; }
        public int            Creator               { get; set; }
        public DateTimeOffset Created               { get; set; }
        public Location       Location              { get; set; }
        public DateTimeOffset StartDateTime         { get; set; }
        public TimeSpan       Duration              { get; set; }
        public int            PricePerPerson        { get; set; }
        public string         CourtName             { get; set; }
        public CourtType      CourtType             { get; set; }
        public string         AdditionalInformation { get; set; }
    }

    public class Location
    {
        public string       Name        { get; set; }
        public BsonDocument Coordinates { get; set; }
    }
}