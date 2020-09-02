using System.Threading.Tasks;

namespace Padel.Login
{
    public interface IFileService
    {
        Task<string> ReadAllLines(string path);
        bool DoesFileExist(string path);
        Task WriteAllBytesAsync(string path, byte[] content);
    }
}