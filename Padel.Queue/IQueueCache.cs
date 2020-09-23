using System.Threading.Tasks;

namespace Padel.Queue
{
    public interface IQueueCache
    {
        Task<string> GetQueueUrl(string queueName);
    }
}