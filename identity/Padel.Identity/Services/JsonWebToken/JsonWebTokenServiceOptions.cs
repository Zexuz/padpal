using System;

namespace Padel.Identity.Services.JsonWebToken
{
    public class JsonWebTokenServiceOptions
    {
        public TimeSpan LifeSpan { get; set; }
    }
}