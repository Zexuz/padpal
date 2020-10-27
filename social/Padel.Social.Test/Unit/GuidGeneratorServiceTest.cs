using Padel.Social.Services.Impl;
using Xunit;

namespace Padel.Social.Test.Unit
{
    public class GuidGeneratorServiceTest
    {
        private readonly GuidGeneratorService _sut;

        public GuidGeneratorServiceTest()
        {
            _sut = new GuidGeneratorService();
        }


        [Fact]
        public void GenerateNewId_should_generate_new_id()
        {
            var id = _sut.GenerateNewId();

            Assert.InRange(id.Length, 32, 32);
        }
    }
}