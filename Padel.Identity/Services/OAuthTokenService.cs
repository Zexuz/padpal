using System;
using System.Threading.Tasks;
using Padel.Identity.Exceptions;
using Padel.Identity.Repositories.Device;
using Padel.Identity.Services.JsonWebToken;

namespace Padel.Identity.Services
{
    public class OAuthTokenService : IOAuthTokenService
    {
        private const int RefreshTokenLength = 64;

        private readonly IJsonWebTokenService _jsonWebTokenService;
        private readonly IDeviceRepository    _deviceRepository;
        private readonly IRandom              _random;

        public OAuthTokenService(IJsonWebTokenService jsonWebTokenService, IDeviceRepository deviceRepository, IRandom random)
        {
            _jsonWebTokenService = jsonWebTokenService;
            _deviceRepository = deviceRepository;
            _random = random;
        }

        public Task InvalidateRefreshToken(int userId, string refreshToken)
        {
            throw new NotImplementedException();
        }

        public async Task<OAuthToken> CreateNewRefreshToken(int userId, ConnectionInfo connectionInfo)
        {
            var (accessToken, expires) = await _jsonWebTokenService.CreateNewAccessToken(userId);
            var refreshToken = GenerateNewDevice(userId, connectionInfo.Ip);

            await _deviceRepository.Insert(refreshToken);

            return new OAuthToken
            {
                Type = OAuthToken.OAuthTokenType.Bearer,
                AccessToken = accessToken,
                RefreshToken = refreshToken.RefreshToken,
                Expires = expires
            };
        }

        public async Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info)
        {
            var dbToken = await _deviceRepository.FindByRefreshToken(refreshToken);

            if (dbToken == null)
                throw new RefreshTokenDoesNotExistException(refreshToken, info);

            if (dbToken.IsDisabled)
                throw new RefreshTokenIsRevokedException(dbToken.Id, info);

            var (accessToken, expires) = await _jsonWebTokenService.CreateNewAccessToken(dbToken.UserId);

            dbToken.LastUsed = DateTimeOffset.UtcNow;
            dbToken.LastUsedFromIp = info.Ip;

            await _deviceRepository.UpdateAsync(dbToken);

            return new OAuthToken
            {
                Expires = expires,
                Type = OAuthToken.OAuthTokenType.Bearer,
                AccessToken = accessToken,
                RefreshToken = refreshToken
            };
        }

        private Device GenerateNewDevice(int userId, string userIp)
        {
            return new Device
            {
                UserId = userId,
                RefreshToken = _random.GenerateSecureString(RefreshTokenLength),
                Created = DateTimeOffset.UtcNow,
                DisabledWhen = null,
                IsDisabled = false,
                LastUsed = DateTimeOffset.UtcNow,
                LastUsedFromIp = userIp
            };
        }
    }
}