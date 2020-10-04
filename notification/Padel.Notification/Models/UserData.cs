using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Proto.Notification.V1;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Models
{
    [BsonCollection("userNotification")]
    public class User : IDocument
    {
        // TODO Add settings here later!
        public ObjectId               Id            { get; set; }
        public int                    UserId        { get; set; }
        public List<string>           FCMTokens     { get; set; } = new List<string>();
        public List<PushNotification> Notifications { get; set; } = new List<PushNotification>();
    }
}