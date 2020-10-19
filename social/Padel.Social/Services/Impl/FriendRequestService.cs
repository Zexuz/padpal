using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Proto.Common.V1;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Services.Impl
{
    public class FriendRequestService : IFriendRequestService
    {
        private readonly IProfileRepository            _profileRepository;
        private readonly IPublisher                    _publisher;
        private readonly ILogger<FriendRequestService> _logger;

        public FriendRequestService(IProfileRepository profileRepository, IPublisher publisher, ILogger<FriendRequestService> logger)
        {
            _profileRepository = profileRepository;
            _publisher = publisher;
            _logger = logger;
        }

        public async Task SendFriendRequest(int fromUserId, int toUserId)
        {
            if (fromUserId == toUserId)
            {
                throw new ArgumentException("from and to can't have the same value");
            }

            var toUser = _profileRepository.FindByUserId(toUserId);
            var fromUser = _profileRepository.FindByUserId(fromUserId);

            if (toUser == null)
            {
                throw new UserDoesNotExistsException(toUserId);
            }

            if (toUser.Friends.Any(friend => friend.UserId == fromUserId))
            {
                throw new AlreadyFriendsException(fromUserId, toUserId);
            }

            if (toUser.FriendRequests.Any(friend => friend.UserId == fromUserId))
            {
                throw new FriendRequestAlreadyExistsException(fromUserId, toUserId);
            }

            var friendRequest = new FriendRequest {UserId = fromUserId};

            toUser.FriendRequests.Add(friendRequest);
            await _profileRepository.ReplaceOneAsync(toUser);

            try
            {
                // TODO Add test that we are reverting the insert!
                await _publisher.PublishMessage(new FriendRequestReceived
                {
                    FromUser = new User
                    {
                        UserId = fromUser.UserId,
                        Name = fromUser.Name,
                        ImgUrl = fromUser.PictureUrl,
                    },
                    ToUser = toUserId,
                });
            }
            catch (Exception e)
            {
                _logger.LogError(e, $"Can't create friend request, from:{fromUserId}, to:{toUserId}");
                toUser.FriendRequests.Remove(friendRequest);
                await _profileRepository.ReplaceOneAsync(toUser);
                throw;
            }
        }

        public async Task RespondToFriendRequest(int fromUserId, int toUserId, RespondToFriendRequestRequest.Types.Action action)
        {
            if (action == RespondToFriendRequestRequest.Types.Action.Unknown)
            {
                throw new ArgumentException($"Action can't be {RespondToFriendRequestRequest.Types.Action.Unknown} ", nameof(action));
            }

            var toUser = _profileRepository.FindByUserId(toUserId);
            var friendRequest = toUser.FriendRequests.SingleOrDefault(friend => friend.UserId == fromUserId);
            if (friendRequest == null)
            {
                throw new NoMatchingFriendRequestFoundException(fromUserId, toUserId);
            }

            switch (action)
            {
                case RespondToFriendRequestRequest.Types.Action.Accept:
                    await AcceptFriendRequest(toUser, fromUserId, friendRequest);
                    break;
                case RespondToFriendRequestRequest.Types.Action.Decline:
                    await DeclineFriendRequest(toUser, friendRequest);
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(action), action, null);
            }
        }

        private async Task AcceptFriendRequest(Profile toUser, int fromUserId, FriendRequest friendRequest)
        {
            var fromUser = _profileRepository.FindByUserId(fromUserId);
            fromUser.Friends.Add(new Friend {UserId = toUser.UserId});
            await _profileRepository.ReplaceOneAsync(fromUser);

            toUser.FriendRequests.Remove(friendRequest);
            toUser.Friends.Add(new Friend {UserId = friendRequest.UserId});
            await _profileRepository.ReplaceOneAsync(toUser);

            await _publisher.PublishMessage(new FriendRequestAccepted
            {
                UserThatAccepted = new User
                {
                    UserId = toUser.UserId,
                    Name = toUser.Name,
                    ImgUrl = toUser.PictureUrl,
                },
                UserThatRequested = friendRequest.UserId,
            });
        }

        private async Task DeclineFriendRequest(Profile toUser, FriendRequest friendRequest)
        {
            toUser.FriendRequests.Remove(friendRequest);
            await _profileRepository.ReplaceOneAsync(toUser);
        }
    }
}