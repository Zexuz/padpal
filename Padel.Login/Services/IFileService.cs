using System.Threading.Tasks;

namespace Padel.Login.Services
{
    public interface IFileService
    {
        Task<string> ReadAllText(string path);
        bool DoesFileExist(string path);
        Task WriteAllText(string path, string content);
    }
}