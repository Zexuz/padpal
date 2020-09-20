using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

namespace Padel.Chat.old
{
    public interface IEntity<TIdentifier>
    {
        TIdentifier Id { get; set; }
    }

    public interface IMongoDbConnectionFactory
    {
        IMongoDatabase Database { get; }
    }

    public interface IRepository<TEntity, TIdentifier> where TEntity : class, IEntity<TIdentifier>
    {
        Task<TEntity>       GetAsync(TIdentifier id);
        Task<List<TEntity>> GetAll();
        Task<TEntity>       SaveAsync(TEntity  entity);
        Task                Delete(TIdentifier id);
        Task                Delete(TEntity     entity);
    }


    public class MongoDbConnectionFactory : IMongoDbConnectionFactory
    {
        public IMongoDatabase Database { get; private set; }

        public MongoDbConnectionFactory(string connectionString, string databaseName)
        {
            var client = new MongoClient(connectionString);
            Database = client.GetDatabase(databaseName);
        }
    }

    public class MongoRepository<TEntity, TIdentifier> : IRepository<TEntity, TIdentifier> where TEntity : class, IEntity<TIdentifier>
    {
        protected readonly IMongoCollection<TEntity> Collection;


        public MongoRepository(IMongoDbConnectionFactory client)
        {
            Collection = client.Database.GetCollection<TEntity>(typeof(TEntity).Name);
        }

        public async Task<TEntity> GetAsync(TIdentifier id)
        {
            return await Collection.Find(x => x.Id.Equals(id)).FirstOrDefaultAsync();
        }

        public Task<List<TEntity>> GetAll()
        {
            return Collection.Find(new BsonDocument()).ToListAsync();
        }

        public async Task<TEntity> SaveAsync(TEntity entity)
        {
            await Collection.ReplaceOneAsync(x => x.Id.Equals(entity.Id), entity, new ReplaceOptions() {IsUpsert = true});

            return entity;
        }

        public async Task Delete(TIdentifier id)
        {
            await Collection.DeleteOneAsync(x => x.Id.Equals(id));
        }

        public async Task Delete(TEntity entity)
        {
            await Collection.DeleteOneAsync(x => x.Id.Equals(entity.Id));
        }
    }

    public class ChatRoomModel : IEntity<string>
    {
        [BsonId] public string Id { get; set; }

        public List<Message> Messages { get; set; } = new List<Message>();
    }
}