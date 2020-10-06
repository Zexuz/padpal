using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Proto.Notification.V1;

namespace Padel.Notification.Service
{
    public interface INotificationService
    {
        Task AddAndSendNotification(IEnumerable<int> userIds, PushNotification pushNotification);
    }
}