using System.Threading.Tasks;
using Amazon.SimpleNotificationService.Model;

namespace Padel.Queue
{
    public interface ITopicService
    {
        Task<Topic> FindTopic(string         name);
        Task<Topic> FindOrCreateTopic(string name);
    }
}