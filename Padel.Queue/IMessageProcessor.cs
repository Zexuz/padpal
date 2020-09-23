using System.Threading.Tasks;
using Amazon.SQS.Model;

namespace Padel.Queue
{
    public interface IMessageProcessor
    {
        public string EventName { get; }
        bool          CanProcess(string eventName);

        Task ProcessAsync(Message message);
    }
}