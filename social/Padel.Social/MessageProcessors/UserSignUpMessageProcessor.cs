using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Proto.Auth.V1;
using Padel.Queue;
using Padel.Social.Exceptions;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Social.MessageProcessors
{
    public class UserSignUpMessageProcessor : IMessageProcessor
    {
        private readonly ILogger<UserSignUpMessageProcessor> _logger;

        public string EventName => UserSignUp.Descriptor.GetMessageName();

        public UserSignUpMessageProcessor
        (
            ILogger<UserSignUpMessageProcessor> logger
        )
        {
            _logger = logger;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var parsed = UserSignUp.Parser.ParseJson(message.Body);
            _logger.LogInformation($"User with id: {parsed.UserId}, name: {parsed.Name} sign up");
        }
    }
}