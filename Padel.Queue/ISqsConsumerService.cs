using System.Threading.Tasks;

namespace Padel.Queue
{
    public interface ISqsConsumerService
    {
        void            StartConsuming();
        void            StopConsuming();
        Task            ReprocessMessagesAsync();
    }
}