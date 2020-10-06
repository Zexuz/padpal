using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Proto.Social.V1;
using Padel.Repository.Core.MongoDb;
using Padel.Social.ValueTypes;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Repositories
{
    public interface IProfileRepository : IMongoRepository<Profile>
    {
        Profile FindByUserId(int userId);
    }
}