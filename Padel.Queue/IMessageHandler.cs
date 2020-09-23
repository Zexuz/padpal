using System.Threading.Tasks;
using Amazon.SQS.Model;

namespace Padel.Queue
{
    public interface IMessageHandler
    {
        Task ProcessAsync(Message message);
    }
}