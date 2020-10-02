using Padel.Social.Models;
using Padel.Social.ValueTypes;

namespace Padel.Social.Factories
{
    public interface IMessageFactory
    {
        Message Build(UserId author, string content);
    }
}