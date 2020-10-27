using System;
using Padel.Social.Services.Interface;

namespace Padel.Social.Services.Impl
{
    public class GuidGeneratorService : IGuidGeneratorService
    {
        public string GenerateNewId()
        {
            return Guid.NewGuid().ToString("N");
        }
    }
}