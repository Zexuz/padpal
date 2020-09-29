using System;

namespace Padel.Test.Core
{
    public class UserGeneratedData
    {
        public string   Username      { get; private set; }
        public string   Email         { get; private set; }
        public string   Name          { get; private set; }
        public string   Password      { get; private set; }
        public DateTime DateOfBirth   { get; private set; }
        public string   FirebaseToken { get; private set; }


        public static UserGeneratedData Random()
        {
            var email = StringGenerator.RandomEmail();
            var password = StringGenerator.RandomPassword();
            var username = StringGenerator.RandomUsername();
            var firebaseToken = StringGenerator.RandomString(20);
            var firstName = StringGenerator.RandomString(10, StringGenerator.Letters);
            var lastName = StringGenerator.RandomString(10, StringGenerator.Letters);
            var name = $"{firstName} {lastName}";
            var dateOfBirth = new DateTime(1996, 11, 07);
            return new UserGeneratedData
            {
                Email = email,
                Password = password,
                Username = username,
                FirebaseToken = firebaseToken,
                Name = name,
                DateOfBirth = dateOfBirth,
            };
        }
    }
}