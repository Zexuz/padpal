using System.IO;
using System.Threading.Tasks;

namespace Padel.Login.Services
{
    public class FileService : IFileService
    {
        public async Task<string> ReadAllText(string path)
        {
            return await File.ReadAllTextAsync(path);
        }

        public bool DoesFileExist(string path)
        {
            return File.Exists(path);
        }

        public Task WriteAllText(string path, string content)
        {
            return File.WriteAllTextAsync(path, content);
        }
    }
}