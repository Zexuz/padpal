using System.Threading.Tasks;

namespace Padel.Queue.Interface
{
    public interface ISubscriptionService
    {
        Task CreateQueueAndSubscribeToTopic();
    }
}