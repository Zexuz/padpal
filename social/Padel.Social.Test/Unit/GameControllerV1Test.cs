using System.Threading.Tasks;
using FakeItEasy;
using MongoDB.Bson;
using Padel.Proto.Game.V1;
using Padel.Social.Runner.Controllers;
using Padel.Social.Services.Interface;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class GameControllerV1Test : TestControllerBase
    {
        private readonly GameControllerV1   _sut;
        private          ICreateGameService _fakeCreateGameService;

        public GameControllerV1Test()
        {
            _fakeCreateGameService = A.Fake<ICreateGameService>();
            _sut = TestHelper.ActivateWithFakes<GameControllerV1>(_fakeCreateGameService);
        }


        [Fact]
        public async Task Insert_and_return_id()
        {
            var ctx = CreateServerCallContextWithUserId(4);
            A.CallTo(() => _fakeCreateGameService.CreateGame(A<int>._, A<CreateGameRequest>._)).Returns(ObjectId.Parse("5f820b655513171764f95f50"));
            
            var res = await _sut.CreateGame(new CreateGameRequest(), ctx);

            Assert.Equal("5f820b655513171764f95f50",res.Id);
        }
    }
}