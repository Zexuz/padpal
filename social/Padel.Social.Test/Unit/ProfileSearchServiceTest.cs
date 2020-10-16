using System.Threading.Tasks;
using FakeItEasy;
using Padel.Proto.Social.V1;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class ProfileSearchServiceTest
    {
        private readonly ProfileSearchService _sut;
        private readonly IProfileRepository   _fakeProfileRepository;

        public ProfileSearchServiceTest()
        {
            _fakeProfileRepository = A.Fake<IProfileRepository>();
            _sut = TestHelper.ActivateWithFakes<ProfileSearchService>(_fakeProfileRepository);
        }

        [Theory]
        [InlineData("  robin", "robin")]
        [InlineData("  robin    ", "robin")]
        [InlineData("robin edbom!23#    ", "robin edbom!23#")]
        [InlineData("robin    edbom    ", "robin    edbom")]
        [InlineData("RoBiN    edbom    ", "RoBiN    edbom")]
        public async Task Should_trim_search_term(string dirty, string expected)
        {
            await _sut.Search(1337, dirty, new SearchForProfileRequest.Types.SearchOptions());

            A.CallTo(() => _fakeProfileRepository.Search(A<int>._, expected, A<SearchForProfileRequest.Types.SearchOptions>._)).MustHaveHappened();
        }

        [Theory]
        [InlineData("  robin", "robin")]
        [InlineData("  robin    ", "robin")]
        [InlineData("robin edbom!23#    ", "robin edbom!23#")]
        [InlineData("robin    edbom    ", "robin    edbom")]
        [InlineData("RoBiN    edbom    ", "RoBiN    edbom")]
        public async Task Should_not_throw_if_request_options_is_null(string dirty, string expected)
        {
            await _sut.Search(1337, dirty, null);

            A.CallTo(() => _fakeProfileRepository.Search(A<int>._, expected, A<SearchForProfileRequest.Types.SearchOptions>._)).MustHaveHappened();
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
            var res = await _sut.Search(1337, term, new SearchForProfileRequest.Types.SearchOptions());

            Assert.Empty(res);
            A.CallTo(() => _fakeProfileRepository.Search(A<int>._, A<string>._, A<SearchForProfileRequest.Types.SearchOptions>._))
                .MustNotHaveHappened();
        }
    }
}