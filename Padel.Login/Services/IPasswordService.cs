namespace Padel.Login.Services
{
    public interface IPasswordService
    {
        string GenerateHashFromPlanText(string password);
        bool IsPasswordOfHash(string passwordHash, string plainPassword);
    }
}