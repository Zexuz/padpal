using System;
using System.Threading.Tasks;
using Grpc.Core;
using Padel.Login.Exceptions;
using Padel.Proto.User.V1;

namespace Padel.Login.GrpcControllers
{
    public class UserControllerV1 : UserService.UserServiceBase
    {
        private readonly Services.IUserService _userService;

        public UserControllerV1(Services.IUserService userService)
        {
            _userService = userService;
        }

        public override async Task<LoginResponse> Login(LoginRequest request, ServerCallContext context)
        {
            try
            {
                await _userService.Login(request);
                return new LoginResponse {Success = true};
            }
            catch (EmailDoesNotExistsException)
            {
                return new LoginResponse{Success = false};
            }
            catch (PasswordDoesNotMatchException)
            {
                return new LoginResponse{Success = false};
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
         
        }

        public override async Task<RegisterResponse> Register(RegisterRequest request, ServerCallContext context)
        {
            try
            {
                await _userService.RegisterNewUser(request.User);
            }
            catch (EmailIsAlreadyTakenException)
            {
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
    }
}