namespace Padel.Login
{
    public interface IRandom
    {
        string GenerateSecureString(int length);
    }
}