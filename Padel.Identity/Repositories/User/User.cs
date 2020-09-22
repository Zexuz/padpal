using System;
using Dapper.Contrib.Extensions;

namespace Padel.Identity.Repositories.User
{
    [Table("[User]")]
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