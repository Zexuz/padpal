using System.Threading.Tasks;

namespace Padel.Queue.Interface
{
    public interface IConsumerService
    {
        void            StartConsuming();
        void            StopConsuming();
        Task            ReprocessMessagesAsync();
    }
}