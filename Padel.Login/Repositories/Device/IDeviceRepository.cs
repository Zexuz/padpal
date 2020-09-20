using System.Threading.Tasks;

namespace Padel.Login.Repositories.Device
{
    public interface IDeviceRepository : IRepositoryBase<Device>
    {
        Task<Device?> FindByRefreshToken(string token);
    }
}