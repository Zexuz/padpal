using System.IO;
using System.Threading.Tasks;

namespace Padel.Social.Services.Interface
{
    public interface IProfilePictureService
    {
        Task         VerifyBucketExists();
        Task<string> Update(int userId, MemoryStream stream);
    }
}