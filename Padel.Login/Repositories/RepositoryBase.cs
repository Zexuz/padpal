using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper.Contrib.Extensions;

namespace Padel.Login.Repositories
{
    public abstract class RepositoryBase<T> : IRepositoryBase<T> where T : class
    {
        protected readonly IDatabaseConnectionFactory ConnectionFactory;

        protected RepositoryBase(IDatabaseConnectionFactory connectionFactory)
        {
            ConnectionFactory = connectionFactory;
        }

        public async Task<T> Get(int id)
        {
            await using var conn = await ConnectionFactory.GetNewOpenConnection();
            return await conn.GetAsync<T>(id);
        }

        public IEnumerable<T> GetAll()
        {
            throw new System.NotImplementedException();
        }

        public async Task<int> Insert(T obj)
        {
            await using var conn = await ConnectionFactory.GetNewOpenConnection();
            return await conn.InsertAsync(obj);
        }

        public int Insert(IEnumerable<T> list)
        {
            throw new System.NotImplementedException();
        }

        public bool Update(T obj)
        {
            throw new System.NotImplementedException();
        }

        public bool Update(IEnumerable<T> list)
        {
            throw new System.NotImplementedException();
        }

        public bool Delete(T obj)
        {
            throw new System.NotImplementedException();
        }

        public bool Delete(IEnumerable<T> list)
        {
            throw new System.NotImplementedException();
        }

        public bool DeleteAll()
        {
            throw new System.NotImplementedException();
        }
    }
}