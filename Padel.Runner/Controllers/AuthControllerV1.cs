using System;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Padel.Login;
using Padel.Login.Exceptions;
using Padel.Proto.Auth.V1;
using Padel.Runner.Extensions;

namespace Padel.Runner.Controllers
{
    // TODO Should be UserAuthController since we are auth the user here.

    // TODO Move all proto stufff here, and have a remapping of the objects to the domain layer
    // The remapping class should also validate syntax, lenght and other stuff, this should be in the domain layer!
    [Authorize]
    public class AuthControllerV1 : AuthService.AuthServiceBase
    {
        private readonly Login.Services.IAuthService _authService;

        public AuthControllerV1(Login.Services.IAuthService authService)
        {
            _authService = authService;
        }

        [AllowAnonymous]
        public override async Task<LoginResponse> Login(LoginRequest request, ServerCallContext context)
        {
            try
            {
                var res = await _authService.Login(request, new ConnectionInfo {Ip = context.GetHttpContext().Connection.RemoteIpAddress.ToString()});
                return new LoginResponse
                {
                    Token = new OAuthToken
                    {
                        Expires = res.Expires.ToUnixTimeSeconds(),
                        Type = OAuthToken.Types.TokenType.Bearer,
                        AccessToken = res.AccessToken,
                        RefreshToken = res.RefreshToken
                    }
                };
            }
            catch (EmailDoesNotExistsException)
            {
                throw new RpcException(Status.DefaultCancelled);
            }
            catch (PasswordDoesNotMatchException)
            {
                throw new RpcException(Status.DefaultCancelled);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        [AllowAnonymous]
        public override async Task<RegisterResponse> Register(RegisterRequest request, ServerCallContext context)
        {
            try
            {
                await _authService.RegisterNewUser(request.User);
            }
            catch (EmailIsAlreadyTakenException)
            {
                // TODO Fix error handeling for Grpc
                var entry = new Metadata.Entry(nameof(request.User.Email), "the value is already taken");
                var metadata = new Metadata();
                metadata.Add(entry);
                metadata.Add("x-custom-error", "email-already-taken");
                throw new RpcException(new Status(StatusCode.InvalidArgument, $"Already taken email"), metadata);
            }
            catch (UsernameIsAlreadyTakenException)
            {
                var entry = new Metadata.Entry(nameof(request.User.Username), "the value is already taken");
                var metadata = new Metadata();
                metadata.Add(entry);
                metadata.Add("x-custom-error", "username-already-taken");
                throw new RpcException(new Status(StatusCode.InvalidArgument, $"Already taken username"), metadata);
            }

            return new RegisterResponse();
        }


        public override async Task<GetNewAccessTokenResponse> GetNewAccessToken(GetNewAccessTokenRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();
            var info = new ConnectionInfo {Ip = context.GetHttpContext().Connection.RemoteIpAddress.ToString()}; // TODO make this better! 
            try
            {
                var res = await _authService.RefreshAccessToken(userId, request.RefreshToken, info);
                return new GetNewAccessTokenResponse
                {
                    Token = new OAuthToken
                    {
                        Expires = res.Expires.ToUnixTimeSeconds(),
                        Type = OAuthToken.Types.TokenType.Bearer,
                        AccessToken = res.AccessToken,
                        RefreshToken = res.RefreshToken,
                    }
                };
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }
    }
}