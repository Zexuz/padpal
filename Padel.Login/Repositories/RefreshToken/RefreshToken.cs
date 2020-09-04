using System;
using Dapper.Contrib.Extensions;

namespace Padel.Login.Repositories.RefreshToken
{
    [Table("[RefreshToken]")]
    public class RefreshToken
    {
        // TODO add constraint that User + Token should be unique!!!
        public int Id { get; set; }
        public int UserId { get; set; }
        public string Token { get; set; }
        public DateTimeOffset Created { get; set; }
        public DateTimeOffset LastUsed { get; set; }
        public bool IsDisabled { get; set; }
        public DateTimeOffset? DisabledWhen { get; set; }
        public string LastUsedFromIp { get; set; }
    }
}