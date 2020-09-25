using System.Threading.Tasks;

namespace Padel.Queue
{
    public interface IConsumerService
    {
        void            StartConsuming();
        void            StopConsuming();
        Task            ReprocessMessagesAsync();
    }
}