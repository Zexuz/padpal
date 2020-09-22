using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Identity.Repositories
{
    public interface IRepositoryBase<T>
    {
        Task<T> Get(int id);
        IEnumerable<T> GetAll();
        Task<int> Insert(T obj);
        int Insert(IEnumerable<T> list);
        Task<bool> UpdateAsync(T obj);
        bool Update(IEnumerable<T> list);
        bool Delete(T obj);
        bool Delete(IEnumerable<T> list);
        bool DeleteAll();
    }
}