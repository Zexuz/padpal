using Padel.Proto.Common.V1;
using Padel.Social.Models;

namespace Padel.Social.Extensions
{
    public static class ProfileExtensions
    {
        public static User ToUser(this Profile profile)
        {
            return new User
            {
                UserId = profile.UserId,
                Name = profile.Name,
                ImgUrl = profile.PictureUrl,
            };
        }
    }
}