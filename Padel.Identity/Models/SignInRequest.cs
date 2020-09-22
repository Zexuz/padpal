namespace Padel.Identity.Models
{
    public class SignInRequest
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string FirebaseToken { get; set; }
    }
}