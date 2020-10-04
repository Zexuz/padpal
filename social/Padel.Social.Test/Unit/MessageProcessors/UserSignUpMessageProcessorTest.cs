using System;
using System.Linq.Expressions;
using System.Text.Json;
using System.Threading.Tasks;
using FakeItEasy;
using Microsoft.Extensions.Logging;
using Padel.Proto.Auth.V1;
using Padel.Repository.Core.MongoDb;
using Padel.Social.MessageProcessors;
using Padel.Social.Models;
using Xunit;
using Message = Amazon.SQS.Model.Message;

namespace Padel.Social.Test.Unit.MessageProcessors
{
    public class UserSignUpMessageProcessorTest
    {
        private readonly UserSignUpMessageProcessor _sut;
        private          IMongoRepository<Profile>     _fakeMongoRepository;

        public UserSignUpMessageProcessorTest()
        {
            _fakeMongoRepository = A.Fake<IMongoRepository<Profile>>();
            var fakeLogger = A.Fake<ILogger<UserSignUpMessageProcessor>>();
            _sut = new UserSignUpMessageProcessor(_fakeMongoRepository, fakeLogger);
        }

        [Fact]
        public async Task Should_insert_to_collection()
        {
            var message = new Message
            {
                Body = JsonSerializer.Serialize(new UserSignUpMessage()
                {
                    Name = "Robin Edbom",
                    UserId = 1337,
                }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase})
            };
            
            A.CallTo(() => _fakeMongoRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(Task.FromResult<Profile>(null));


            await _sut.ProcessAsync(message);

            A.CallTo(() => _fakeMongoRepository.InsertOneAsync(A<Profile>.That.Matches(user =>
                    user.Name   == "Robin Edbom" &&
                    user.UserId == 1337
                )
            )).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_throw_exception_if_user_already_exists()
        {
            var message = new Message
            {
                Body = JsonSerializer.Serialize(new UserSignUpMessage()
                {
                    Name = "Robin Edbom",
                    UserId = 1337,
                }, new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase})
            };

            A.CallTo(() => _fakeMongoRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(new Profile());

            var ex = await Assert.ThrowsAsync<Exception>(() => _sut.ProcessAsync(message));
        }
    }
}