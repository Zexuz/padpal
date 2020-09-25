using System.Collections.Generic;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;
using Microsoft.Extensions.Logging;
using Padel.Notification.Extensions;
using Padel.Proto.Chat.V1;
using Padel.Queue;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Notification.MessageProcessors
{
    public class ChatMessageReceivedProcessor : IMessageProcessor
    {
        private string[] tokens = new[]
        {
            "dxWWnWfFSCquu8lu7yxAdy:APA91bFvSDE2Yu0ENdPBv3gw0SByIj2mxG2JnXzRWUBAyslyZuAAUIf7tV7oDTsltFVLgAPQNdGaEKiIBAQljeYZKisH8oQMkH2nVLjibHQ08MPYEu9on3TO4CsGAlDFHzq3dvAXTyJ7",
            "cOdCjt1yQy64LgnHcaKMk-:APA91bHJFjQXebx73uLZhG_SDN7e4VdazsP8hkx1-f1be96JEWRyxtYnOtOo6GVmGyoOtMIMPHGSlcwHjm-cN91PGjeRalV_Wr-jjngxmIrpvyZSB0WwfQoCRQwzgi10-AqGtTACD_Ab",
            // "cUzvHK92Se-AtRdA9cd7qB:APA91bGjmdRjBQtMVRSA6_WhR_UUFguepoKwFz7VUpb3ybGHxILMeXMtwhNC1CxAPJU47p5kk7rczbLfF8r6MVU8IJQTM8gjS3A5Yl6CmdWDjxOXi4_PF9xnsX58d5gyMQlCu434cB64",
            //This is my onePLus
        };

        private readonly ILogger<ChatMessageReceivedProcessor> _logger;

        public string EventName => ChatMessageReceived.Descriptor.GetMessageName();

        public ChatMessageReceivedProcessor(ILogger<ChatMessageReceivedProcessor> logger)
        {
            _logger = logger;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            await FirebaseMessaging.DefaultInstance.SendMulticastAsync(new MulticastMessage
            {
                Data = new Dictionary<string, string>
                {
                    // {"type", pushNotification.MessageType},
                    // {"content", JsonSerializer.Serialize(pushNotification.Message)},
                    {"type", EventName},
                    {"content", message.Body},
                },
                Tokens = tokens
            });
            _logger.LogInformation($"Message: {EventName}, body: {message.Body}");
        }
    }
}