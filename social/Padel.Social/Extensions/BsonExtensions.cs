using MongoDB.Bson;

namespace Padel.Social.Extensions
{
    public static class BsonExtensions
    {
        public static (double lng, double lat) GetLatLng(this BsonDocument document)
        {
            var arr = document.GetElement("coordinates").Value.AsBsonArray;
            return (arr[0].AsDouble, arr[1].AsDouble);
        }
    }
}