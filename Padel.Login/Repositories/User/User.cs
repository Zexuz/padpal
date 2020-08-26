using System;
using Dapper.Contrib.Extensions;
using Padel.Proto.User;

namespace Padel.Login.Repositories.User
{
    [Table("user")]
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string PasswordHash { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public DateTimeOffset Created { get; set; }
    }
}