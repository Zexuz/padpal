using System.Collections.Generic;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;

namespace Padel.Chat.Services
{
    public class PushNotificationService
    {
        private string[] tokens = new[]
        {
            "dxWWnWfFSCquu8lu7yxAdy:APA91bFvSDE2Yu0ENdPBv3gw0SByIj2mxG2JnXzRWUBAyslyZuAAUIf7tV7oDTsltFVLgAPQNdGaEKiIBAQljeYZKisH8oQMkH2nVLjibHQ08MPYEu9on3TO4CsGAlDFHzq3dvAXTyJ7",
            "cOdCjt1yQy64LgnHcaKMk-:APA91bHJFjQXebx73uLZhG_SDN7e4VdazsP8hkx1-f1be96JEWRyxtYnOtOo6GVmGyoOtMIMPHGSlcwHjm-cN91PGjeRalV_Wr-jjngxmIrpvyZSB0WwfQoCRQwzgi10-AqGtTACD_Ab",
            // "cUzvHK92Se-AtRdA9cd7qB:APA91bGjmdRjBQtMVRSA6_WhR_UUFguepoKwFz7VUpb3ybGHxILMeXMtwhNC1CxAPJU47p5kk7rczbLfF8r6MVU8IJQTM8gjS3A5Yl6CmdWDjxOXi4_PF9xnsX58d5gyMQlCu434cB64",
            //This is my onePLus
        };

        public async Task SendMessage(string message)
        {
            var type = "chat-message";

            await FirebaseMessaging.DefaultInstance.SendMulticastAsync(new MulticastMessage
            {
                Data = new Dictionary<string, string>
                {
                    {"type", type},
                    {"title", "New message"},
                    {"content", message},
                },
                Tokens = tokens
            });
        }
    }
}