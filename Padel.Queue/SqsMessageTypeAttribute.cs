using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Amazon.SQS.Model;
using Newtonsoft.Json;

namespace Padel.Queue
{
    // public partial class Root
    // {
    //
    //     [JsonProperty("MessageAttributes")]
    //     public MessageAttributes MessageAttributes { get; set; }
    // }
    //
    // public partial class MessageAttributes
    // {
    //     [JsonProperty("somename")]
    //     public Somename Somename { get; set; }
    // }
    //
    // public partial class Somename
    // {
    //     [JsonProperty("Type")]
    //     public string Type { get; set; }
    //
    //     [JsonProperty("Value")]
    //     public string Value { get; set; }
    // }
    //
    // public partial class Temperatures
    // {
    //     public static Temperatures FromJson(string json) => JsonConvert.DeserializeObject<Temperatures>(json, QuickType.Converter.Settings);
    // }
    //
    // public static class Serialize
    // {
    //     public static string ToJson(this Temperatures self) => JsonConvert.SerializeObject(self, QuickType.Converter.Settings);
    // }
    //
    // internal static class Converter
    // {
    //     public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
    //     {
    //         MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
    //         DateParseHandling = DateParseHandling.None,
    //         Converters =
    //         {
    //             new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
    //         },
    //     };
    // }
    
    public static class SqsMessageTypeAttribute
    {
        private const string AttributeName = "MessageType";


        public static string GetMessageTypeAttributeValue(this Message message)
        {
            
            return "";
        }
        
        public static string GetMessageTypeAttributeValue(this Dictionary<string, MessageAttributeValue> attributes)
        {
            return attributes.SingleOrDefault(x => x.Key == AttributeName).Value?.StringValue;
        }

        public static Dictionary<string, MessageAttributeValue> CreateAttributes<T>()
        {
            return CreateAttributes(typeof(T).Name);
        }

        public static Dictionary<string, MessageAttributeValue> CreateAttributes(string messageType)
        {
            return new Dictionary<string, MessageAttributeValue>
            {
                {
                    AttributeName, new MessageAttributeValue
                    {
                        DataType = nameof(String),
                        StringValue = messageType
                    }
                }
            };
        }
    }
}