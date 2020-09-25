using System.Threading.Tasks;
using FirebaseAdmin.Messaging;

namespace Padel.Notification
{
    public interface IFirebaseCloudMessaging
    {
        Task<BatchResponse> SendMulticastAsync(MulticastMessage message);
    }
}