﻿using System.Threading.Tasks;
using Grpc.Core;
using Padel.Grpc.Core;
using Padel.Identity.Repositories.User;
using Padel.Proto.User.V1;

namespace Padel.Identity.Runner.Controllers
{
    // TODO Rename this conteoller to MeController, b/c this is where we fetch data about the current user?
    // Lets combine Me and UserService untill we know how it will be implemented
    // THere will be another UserController where we can fetch data about other users
    public class UserControllerV1 : UserService.UserServiceBase
    {
        private readonly IUserRepository _userRepository;

        public UserControllerV1(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public override async Task<MeResponse> Me(MeRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();
            var user = await _userRepository.Get(userId);
            return new MeResponse
            {
                Me = new Me
                {
                    Email = user.Email,
                    Name = user.Name,
                }
            };
        }
    }
}