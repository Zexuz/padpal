using System.Threading.Tasks;

namespace Padel.Chat.old
{
    public interface IMessageWriter
    {
        Task Write(string message);
    }
}