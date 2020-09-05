using System;
using System.Threading.Tasks;
using Padel.Login.Exceptions;
using Padel.Login.Repositories.RefreshToken;
using Padel.Login.Services.JsonWebToken;

namespace Padel.Login.Services
{
    public class OAuthTokenService : IOAuthTokenService
    {
        private const int RefreshTokenLength = 64;

        private readonly IJsonWebTokenService    _jsonWebTokenService;
        private readonly IRefreshTokenRepository _refreshTokenRepository;
        private readonly IRandom                 _random;

        public OAuthTokenService(IJsonWebTokenService jsonWebTokenService, IRefreshTokenRepository refreshTokenRepository, IRandom random)
        {
            _jsonWebTokenService = jsonWebTokenService;
            _refreshTokenRepository = refreshTokenRepository;
            _random = random;
        }

        public Task InvalidateRefreshToken(int userId, string refreshToken)
        {
            throw new NotImplementedException();
        }

        public async Task<OAuthToken> CreateNewRefreshToken(int userId, ConnectionInfo connectionInfo)
        {
            var (accessToken, expires) = await _jsonWebTokenService.CreateNewAccessToken(userId);
            var refreshToken = GenerateRefreshToken(userId, connectionInfo.Ip);

            await _refreshTokenRepository.Insert(refreshToken);

            return new OAuthToken
            {
                Type = OAuthToken.OAuthTokenType.Bearer,
                AccessToken = accessToken,
                RefreshToken = refreshToken.Token,
                Expires = expires
            };
        }

        public async Task<OAuthToken> RefreshAccessToken(string refreshToken, ConnectionInfo info)
        {
            var dbToken = await _refreshTokenRepository.FindToken(refreshToken);

            if (dbToken == null)
                throw new RefreshTokenDoesNotExistException(refreshToken, info);

            if (dbToken.IsDisabled)
                throw new RefreshTokenIsRevokedException(dbToken.Id, info);

            var (accessToken, expires) = await _jsonWebTokenService.CreateNewAccessToken(dbToken.UserId);

            dbToken.LastUsed = DateTimeOffset.UtcNow;
            dbToken.LastUsedFromIp = info.Ip;

            await _refreshTokenRepository.UpdateAsync(dbToken);

            return new OAuthToken
            {
                Expires = expires,
                Type = OAuthToken.OAuthTokenType.Bearer,
                AccessToken = accessToken,
                RefreshToken = refreshToken
            };
        }

        private RefreshToken GenerateRefreshToken(int userId, string userIp)
        {
            return new RefreshToken
            {
                UserId = userId,
                Token = _random.GenerateSecureString(RefreshTokenLength),
                Created = DateTimeOffset.UtcNow,
                DisabledWhen = null,
                IsDisabled = false,
                LastUsed = DateTimeOffset.UtcNow,
                LastUsedFromIp = userIp
            };
        }
    }
}