using System.Collections.Generic;
using MongoDB.Bson;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification
{
    public class NotificationServiceRepoModel : IDocument
    {
        public ObjectId     Id        { get; set; }
        public int          UserId    { get; set; }
        public List<string> FCMTokens { get; set; }
    }
}