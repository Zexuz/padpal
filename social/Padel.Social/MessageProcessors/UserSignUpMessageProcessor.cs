using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Proto.Auth.V1;
using Padel.Queue;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Social.MessageProcessors
{
    public class UserSignUpMessageProcessor : IMessageProcessor
    {
        private readonly IMongoRepository<Profile>              _userRepository;
        private readonly ILogger<UserSignUpMessageProcessor> _logger;

        public string EventName => UserSignUpMessage.Descriptor.GetMessageName();

        public UserSignUpMessageProcessor(
            IMongoRepository<Profile>              userRepository,
            ILogger<UserSignUpMessageProcessor> logger
        )
        {
            _userRepository = userRepository;
            _logger = logger;
        }

        public bool CanProcess(string eventName)
        {
            return eventName == EventName;
        }

        public async Task ProcessAsync(Message message)
        {
            var parsed = UserSignUpMessage.Parser.ParseJson(message.Body);

            var res = await _userRepository.FindOneAsync(user => user.UserId == parsed.UserId);
            if (res != null)
            {
                throw new Exception($"User with id {parsed.UserId} already exists");
            }

            await _userRepository.InsertOneAsync(new Profile
            {
                Name = parsed.Name,
                UserId = parsed.UserId,
            });

            _logger.LogInformation($"User with id: {parsed.UserId}, name: {parsed.Name} sign up");
        }
    }
}