using System;
using Dapper.Contrib.Extensions;

namespace Padel.Identity.Repositories.Device
{
    [Table("[Device]")]
    public class Device
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string RefreshToken { get; set; }
        public DateTimeOffset Created { get; set; }
        public DateTimeOffset LastUsed { get; set; }
        public bool IsDisabled { get; set; }
        public DateTimeOffset? DisabledWhen { get; set; }
        public string LastUsedFromIp { get; set; }
    }
}