using Padel.Login.Services;
using Xunit;

namespace Padel.Login.Test
{
    public class PasswordServiceTest
    {

        [Fact]
        public void Should_Generate_Hash_From_Password()
        {
            var passwordService = new PasswordService();

            var hash = passwordService.GenerateHashFromPlanText("some REALLY good passw0rod 1@£4");

            var parts = hash.Split('.');

            Assert.Equal(3, parts.Length);
            Assert.Equal("100000", parts[0]);
        }

        [Theory]
        [InlineData("1000.1FgGSY2fweo=.3HR7YRWo0LseMQPPlcZP58K/VCOY09PvdAR0n9q1mVLrt02fEtrSOw1BvNQq", "some REALLY good passw0rod 1@£4")]
        [InlineData("1000.vOVgPQdmf5I=.+mB3nsjBrut+U2m5mfgohP/FP7QhNSIAVRK3CVyoZt8HxixWn0KZveaUjYIQ", "some REALLY good passw0rod 1@£4")]
        public void Should_Verify_That_PlainPassword_Matches_Hash(string passwordHash, string plainPassword)
        {
            var passwordService = new PasswordService();

            var res = passwordService.IsPasswordOfHash(passwordHash, plainPassword);

            Assert.True(res);
        }
    }
}