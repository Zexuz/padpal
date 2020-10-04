using System;

namespace Padel.Test.Core
{
    public class UserGeneratedData
    {
        public string   Email         { get; private set; }
        public string   Name          { get; private set; }
        public string   Password      { get; private set; }
        public DateTime DateOfBirth   { get; private set; }
        public string   FirebaseToken { get; private set; }


        public static UserGeneratedData Random()
        {
            var email = TestHelper.RandomEmail();
            var password = TestHelper.RandomPassword();
            var firebaseToken = TestHelper.RandomString(20);
            var firstName = TestHelper.RandomString(10, TestHelper.Letters);
            var lastName = TestHelper.RandomString(10, TestHelper.Letters);
            var name = $"{firstName} {lastName}";
            var dateOfBirth = new DateTime(1996, 11, 07);
            return new UserGeneratedData
            {
                Email = email,
                Password = password,
                FirebaseToken = firebaseToken,
                Name = name,
                DateOfBirth = dateOfBirth,
            };
        }
    }
}