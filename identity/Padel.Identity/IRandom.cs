namespace Padel.Identity
{
    public interface IRandom
    {
        string GenerateSecureString(int length);
    }
}