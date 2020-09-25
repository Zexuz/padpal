namespace Padel.Repository.Core.MongoDb
{
    public interface IMongoDbSettings
    {
        string DatabaseName     { get; set; }
        string ConnectionString { get; set; }
    }
}