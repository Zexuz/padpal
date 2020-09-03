using System;
using Dapper.Contrib.Extensions;

namespace Padel.Login.Repositories.RefreshToken
{

    [Table("[RefreshToken]")]
    public class RefreshToken
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int UserAgent { get; set; } // TODO Remove, this does not need to be in the SQL Database, This should be moved to Kibana 
        public string Token { get; set; }
        public DateTimeOffset ValidTo { get; set; } // TODO Remove this, have no use for it.
        public DateTimeOffset Created { get; set; }
        public DateTimeOffset LastUsed { get; set; }
        public bool IsDisabled { get; set; }
        public DateTimeOffset? DisabledWhen { get; set; }
        public string IssuedFromIp { get; set; } // TODO Remove this, have no use for it.
        public string LastUsedFromIp { get; set; }
    }
}