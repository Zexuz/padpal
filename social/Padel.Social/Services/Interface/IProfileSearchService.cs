using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Social.Models;

namespace Padel.Social.Services.Interface
{
    public interface IProfileSearchService
    {
        Task<IReadOnlyCollection<Profile>> Search(string searchTerm);
    }
}