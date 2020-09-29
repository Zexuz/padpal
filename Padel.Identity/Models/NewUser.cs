using System;

namespace Padel.Identity.Models
{
    public class NewUser
    {
        public string   Email       { get; set; }
        public string   Username    { get; set; }
        public string   Password    { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string   Name        { get; set; }
    }
}