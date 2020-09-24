using System;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Identity.Exceptions;
using Padel.Proto.Auth.V1;
using AuthService = Padel.Proto.Auth.V1.AuthService;
using NewUser = Padel.Identity.Models.NewUser;
using Padel.Grpc.Core;

namespace Padel.Identity.Runner.Controllers
{
    // TODO Should be UserAuthController since we are auth the user here.

    // TODO Move all proto stufff here, and have a remapping of the objects to the domain layer
    // The remapping class should also validate syntax, lenght and other stuff, this should be in the domain layer!
    public class AuthControllerV1 : AuthService.AuthServiceBase
    {
        private readonly Identity.Services.IAuthService _authService;

        public AuthControllerV1(Identity.Services.IAuthService authService)
        {
            _authService = authService;
        }

        public override async Task<SignInResponse> SignIn(SignInRequest request, ServerCallContext context)
        {
            var connectionInfo = new ConnectionInfo {Ip = context.GetHttpContext().Connection.RemoteIpAddress.ToString()};
            var signInRequest = new Identity.Models.SignInRequest
            {
                Email = request.Email,
                Password = request.Password,
                FirebaseToken = request.FirebaseToken
            };
            try
            {
                var res = await _authService.SignIn(signInRequest, connectionInfo);
                return new SignInResponse
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

        public override async Task<RegisterResponse> Register(RegisterRequest request, ServerCallContext context)
        {
            var user = new NewUser()
            {
                Email = request.User.Email,
                Password = request.User.Password,
                Username = request.User.Username,
                FirstName = request.User.FirstName,
                LastName = request.User.LastName,
                DateOfBirth = DateTime.Parse($"{request.User.DateOfBirth.Year}-{request.User.DateOfBirth.Month}-{request.User.DateOfBirth.Day}")
            };
            try
            {
                await _authService.RegisterNewUser(user);
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
            var info = new ConnectionInfo {Ip = context.GetIPv4().ToString()};
            try
            {
                var res = await _authService.RefreshAccessToken(request.RefreshToken, info);
                return new GetNewAccessTokenResponse
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
            catch (Exception e)
            {
                // TODO Logging and error handeling
                Console.WriteLine(e);
                throw;
            }
        }
    }
}