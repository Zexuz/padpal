using System.Threading.Tasks;

namespace Padel.Login
{
    public interface IFileService
    {
        Task<string> ReadAllText(string path);
        bool DoesFileExist(string path);
        Task WriteAllText(string path, string content);
    }
}