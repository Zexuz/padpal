using System.Threading.Tasks;
using FirebaseAdmin.Messaging;

namespace Padel.Notification
{
    public class FirebaseCloudMessagingWrapper : IFirebaseCloudMessaging
    {
        public Task<BatchResponse> SendMulticastAsync(MulticastMessage message)
        {
            throw new System.NotImplementedException();
        }
    }
}