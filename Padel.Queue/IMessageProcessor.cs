using System.Threading.Tasks;
using Amazon.SQS.Model;

namespace Padel.Queue
{
    public interface IMessageProcessor
    {
        bool CanProcess(string messageType);

        Task ProcessAsync(Message message);
    }
}