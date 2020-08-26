using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Login.Test
{
    public interface IRepositoryBase<T>
    {
        Task<T> Get(int id);
        IEnumerable<T> GetAll();
        int Insert(T obj);
        int Insert(IEnumerable<T> list);
        bool Update(T obj);
        bool Update(IEnumerable<T> list);
        bool Delete(T obj);
        bool Delete(IEnumerable<T> list);
        bool DeleteAll();
    }
}