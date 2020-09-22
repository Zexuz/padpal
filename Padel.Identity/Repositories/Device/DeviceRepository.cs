using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;

namespace Padel.Identity.Repositories.Device
{
    public class DeviceRepository : RepositoryBase<Device>, IDeviceRepository
    {
        public DeviceRepository(IDatabaseConnectionFactory connectionFactory) : base(connectionFactory)
        {
        }

        public async Task<Device?> FindByRefreshToken(string token)
        {
            var dictionary = new Dictionary<string, object>
            {
                {"@token", token}
            };

            using var conn = await ConnectionFactory.GetNewOpenConnection();
            return await conn.QuerySingleOrDefaultAsync<Device>("SELECT * from Device where RefreshToken = @token", dictionary);
        }
    }
}