using System;
using System.Threading.Tasks;
using Padel.Login.Repositories.RefreshToken;
using Padel.Login.Repositories.User;
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

        public Task InvalidateRefreshToken(User user, string refreshToken)
        {
            throw new System.NotImplementedException();
        }

        public async Task<OAuthToken> CreateNewRefreshToken(User user, ConnectionInfo connectionInfo)
        {
            var (accessToken, expires) = await _jsonWebTokenService.CreateNewAccessToken(user);
            var refreshToken = GenerateRefreshToken(user, connectionInfo.Ip);

            await _refreshTokenRepository.Insert(refreshToken);

            return new OAuthToken
            {
                Type = OAuthToken.OAuthTokenType.Bearer,
                AccessToken = accessToken,
                RefreshToken = refreshToken.Token,
                Expires = expires
            };
        }

        public async Task<OAuthToken> CreateNewAccessToken(int userId, string refreshToken, ConnectionInfo info)
        {
            var dbToken = await _refreshTokenRepository.FindToken(userId, refreshToken);

            if (dbToken.IsDisabled)
            {
                throw new NotImplementedException();
            }

            var (accessToken, expires) = await _jsonWebTokenService.CreateNewAccessToken(new User {Id = userId}); // TODO REFACTOR! 
            
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

        private RefreshToken GenerateRefreshToken(User user, string userIp)
        {
            return new RefreshToken
            {
                UserId = user.Id,
                Token = _random.GenerateSecureString(RefreshTokenLength),
                Created = DateTimeOffset.UtcNow,
                DisabledWhen = null,
                IsDisabled = false,
                LastUsed = DateTimeOffset.UtcNow,
                LastUsedFromIp = userIp,
            };
        }
    }
}