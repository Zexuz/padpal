using System.Threading.Tasks;

namespace Padel.Queue
{
    public interface ISubscriptionService
    {
        Task CreateQueueAndSubscribeToTopic();
    }
}