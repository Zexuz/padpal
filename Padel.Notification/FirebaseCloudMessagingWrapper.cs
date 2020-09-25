using System.Threading.Tasks;
using FirebaseAdmin;
using FirebaseAdmin.Messaging;

namespace Padel.Notification
{
    public class FirebaseCloudMessagingWrapper : IFirebaseCloudMessaging
    {
        private readonly FirebaseMessaging _firebaseMessaging;

        public FirebaseCloudMessagingWrapper()
        {
            _firebaseMessaging = FirebaseMessaging.GetMessaging(FirebaseApp.DefaultInstance ?? FirebaseApp.Create());
        }

        public async Task<BatchResponse> SendMulticastAsync(MulticastMessage message)
        {
            return await _firebaseMessaging.SendMulticastAsync(message);
        }
    }
}