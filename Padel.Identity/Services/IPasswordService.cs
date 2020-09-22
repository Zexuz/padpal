namespace Padel.Identity.Services
{
    public interface IPasswordService
    {
        string GenerateHashFromPlanText(string password);
        bool IsPasswordOfHash(string passwordHash, string plainPassword);
    }
}