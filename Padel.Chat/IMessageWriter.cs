using System.Threading.Tasks;

namespace Padel.Chat
{
    public interface IMessageWriter
    {
        Task Write(string message);
    }
}