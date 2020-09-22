namespace Padel.Chat.Repositories.MongoDb
{
    public interface IMongoDbSettings
    {
        string DatabaseName     { get; set; }
        string ConnectionString { get; set; }
    }
}