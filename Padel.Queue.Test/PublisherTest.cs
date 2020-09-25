using System;
using System.Threading;
using System.Threading.Tasks;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;
using FakeItEasy;
using Xunit;

namespace Padel.Queue.Test
{
    public class PublisherTest
    {
        private class MyTestJsonClass
        {
            public string ThisIsMyObject { get; set; }
        }

        private readonly Publisher                        _sut;
        private readonly ITopicService                    _fakeTopicService;
        private readonly IAmazonSimpleNotificationService _fakeAmazonSimpleNotificationService;

        public PublisherTest()
        {
            _fakeAmazonSimpleNotificationService = A.Fake<IAmazonSimpleNotificationService>();
            _fakeTopicService = A.Fake<ITopicService>();

            _sut = new Publisher(_fakeAmazonSimpleNotificationService, _fakeTopicService);
        }


        [Fact]
        public async Task Should_serialize_json_to_camelCase()
        {
            await _sut.RegisterEvent("myName", typeof(MyTestJsonClass));
            var message = new MyTestJsonClass {ThisIsMyObject = "HelloWorld"};

            await _sut.PublishMessage(message);

            A.CallTo(() => _fakeAmazonSimpleNotificationService.PublishAsync(A<PublishRequest>.That.Matches(request =>
                    request.Message == "{\"thisIsMyObject\":\"HelloWorld\"}"
                ), A<CancellationToken>._)
            ).MustHaveHappenedOnceExactly();
        }
    }
}