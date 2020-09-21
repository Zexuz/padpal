using System;
using Padel.Proto.Auth.V1;
using Padel.Runner.Test.IntegrationTests.Helpers;

namespace Padel.Runner.Test.IntegrationTests
{
    public class UserGeneratedData
    {
        public string   Username      { get; private set; }
        public string   Email         { get; private set; }
        public string   Password      { get; private set; }
        public string   FirstName     { get; private set; }
        public string   LastName      { get; private set; }
        public DateTime DateOfBirth   { get; private set; }
        public string   FirebaseToken { get; private set; }
        public NewUser  NewUser       { get; private set; }


        public static UserGeneratedData Random()
        {
            var email = StringGenerator.RandomEmail();
            var password = StringGenerator.RandomPassword();
            var username = StringGenerator.RandomUsername();
            var firebaseToken = StringGenerator.RandomString(20);
            var firstName = StringGenerator.RandomString(10, StringGenerator.Letters);
            var lastName = StringGenerator.RandomString(10, StringGenerator.Letters);
            var dateOfBirth = new DateTime(1996, 11, 07);
            return new UserGeneratedData
            {
                Email = email,
                Password = password,
                Username = username,
                FirebaseToken = firebaseToken,
                FirstName = firstName,
                LastName = lastName,
                DateOfBirth = dateOfBirth,
                NewUser = new NewUser
                {
                    Username = username,
                    Email = email,
                    Password = password,
                    FirstName = firstName,
                    LastName = lastName,
                    DateOfBirth = new NewUser.Types.Date {Year = dateOfBirth.Year, Month = dateOfBirth.Month, Day = dateOfBirth.Day}
                },
            };
        }
    }
}