using System.Threading.Tasks;

namespace Padel.Identity.Repositories.Device
{
    public interface IDeviceRepository : IRepositoryBase<Device>
    {
        Task<Device?> FindByRefreshToken(string token);
    }
}