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
        private readonly IMongoDatabase _database;

        public MongoRepository(IMongoDbConnectionFactory client)
        {
            _database = client.Database;
        }

        public async Task<TEntity> GetAsync(TIdentifier id)
        {
            return await _database.GetCollection<TEntity>(typeof(TEntity).Name).Find(x => x.Id.Equals(id)).FirstOrDefaultAsync();
        }

        public Task<List<TEntity>> GetAll()
        {
            return _database.GetCollection<TEntity>(typeof(TEntity).Name).Find(new BsonDocument()).ToListAsync();
        }

        public async Task<TEntity> SaveAsync(TEntity entity)
        {
            var collection = _database.GetCollection<TEntity>(typeof(TEntity).Name);

            await collection.ReplaceOneAsync(x => x.Id.Equals(entity.Id), entity, new ReplaceOptions() {IsUpsert = true});

            return entity;
        }

        public async Task Delete(TIdentifier id)
        {
            var collection = _database.GetCollection<TEntity>(typeof(TEntity).Name);

            await collection.DeleteOneAsync(x => x.Id.Equals(id));
        }

        public async Task Delete(TEntity entity)
        {
            var collection = _database.GetCollection<TEntity>(typeof(TEntity).Name);

            await collection.DeleteOneAsync(x => x.Id.Equals(entity.Id));
        }
    }

    public class ChatRoomModel : IEntity<string>
    {
        [BsonId] public string Id { get; set; }

        public List<Message> Messages { get; set; } = new List<Message>();
    }
}