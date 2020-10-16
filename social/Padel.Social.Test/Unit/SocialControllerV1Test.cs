using System.Threading.Tasks;
using FakeItEasy;
using Grpc.Core;
using Padel.Proto.Social.V1;
using Padel.Social.Runner.Controllers;
using Padel.Social.Services.Interface;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class SocialControllerV1Test : TestControllerBase
    {
        private readonly SocialControllerV1    _sut;
        private readonly IProfileSearchService _fakeProfileSearchService;
        private          ServerCallContext     _ctx;

        public SocialControllerV1Test()
        {
            _fakeProfileSearchService = A.Fake<IProfileSearchService>();
            _ctx = CreateServerCallContextWithUserId(1337);

            _sut = TestHelper.ActivateWithFakes<SocialControllerV1>(_fakeProfileSearchService);
        }


        [Theory]
        [InlineData("  robin", "robin")]
        [InlineData("  robin    ", "robin")]
        [InlineData("robin edbom!23#    ", "robin edbom!23#")]
        [InlineData("robin    edbom    ", "robin    edbom")]
        [InlineData("RoBiN    edbom    ", "RoBiN    edbom")]
        public async Task Should_trim_search_term(string dirty, string expected)
        {
            await _sut.SearchForProfile(new SearchForProfileRequest {SearchTerm = dirty}, _ctx);

            A.CallTo(() => _fakeProfileSearchService.Search(A<int>._, expected, A<SearchForProfileRequest.Types.SearchOptions>._)).MustHaveHappened();
        }

        [Theory]
        [InlineData("")]
        [InlineData(" ")]
        [InlineData("    ")]
        [InlineData("      ")]
        [InlineData("!\"")]
        [InlineData("   ro   ")]
        public async Task Should_not_search_if_term_is_missing_or_to_short(string term)
        {
            var res = await _sut.SearchForProfile(new SearchForProfileRequest {SearchTerm = term}, _ctx);

            Assert.Empty(res.Profiles);
            A.CallTo(() => _fakeProfileSearchService.Search(A<int>._, A<string>._, A<SearchForProfileRequest.Types.SearchOptions>._))
                .MustNotHaveHappened();
        }
    }
}