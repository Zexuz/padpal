// using System;
// using System.Collections.Generic;
// using System.Data;
// using System.Threading.Tasks;
// using Dapper;
// using FakeItEasy;
// using Padel.Login.Repositories;
// using Padel.Login.Repositories.User;
// using Xunit;
//
// namespace Padel.Login.Test
// {
//     public class UserRepositoryTest
//     {
//         private readonly UserRepository _sut;
//         private readonly IDbConnection  _fakeDbConnection;
//
//
//         public UserRepositoryTest()
//         {
//             var fakeDatabaseConnection = A.Fake<IDatabaseConnectionFactory>();
//             _fakeDbConnection = A.Fake<IDbConnection>();
//
//             A.CallTo(() => fakeDatabaseConnection.GetNewOpenConnection()).Returns(_fakeDbConnection);
//
//             _sut = new UserRepository(fakeDatabaseConnection);
//         }
//
//         [Fact]
//         public async Task Should_return_user_when_searching_for_existing_username()
//         {
//             A.CallTo(() => _fakeDbConnection.QuerySingleOrDefaultAsync<User>(
//                 A<string>._,
//                 A<Dictionary<string, string>>._,
//                 null,
//                 null,
//                 null
//             )).Returns(new User
//             {
//                 Email = "email@qwe.com",
//                 Username = "someUsername"
//             });
//
//             var res = await _sut.FindByUsername("someUsername");
//
//             Assert.Equal("someUsername", res.Username);
//             Assert.Equal("email@qwe.com", res.Email);
//
//             A.CallTo(() => _fakeDbConnection.QuerySingleOrDefaultAsync<User>(
//                 A<string>._,
//                 A<Dictionary<string, string>>._,
//                 null,
//                 null,
//                 null
//             )).MustHaveHappenedOnceExactly();
//         }
//     }
// }