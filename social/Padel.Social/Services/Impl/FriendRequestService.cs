using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Services.Interface;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Services.Impl
{
    public class FriendRequestService : IFriendRequestService
    {
        private readonly IMongoRepository<Profile>     _profileRepository;
        private readonly IPublisher                    _publisher;
        private readonly ILogger<FriendRequestService> _logger;

        public FriendRequestService(IMongoRepository<Profile> profileRepository, IPublisher publisher, ILogger<FriendRequestService> logger)
        {
            _profileRepository = profileRepository;
            _publisher = publisher;
            _logger = logger;
        }

        public async Task MakeFriendRequest(int fromUserId, int toUserId)
        {
            var toUser = await _profileRepository.FindOneAsync(profile => profile.UserId == toUserId);

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
                await _publisher.PublishMessage(new FriendRequestReceived
                {
                    FromUser = fromUserId,
                    ToUser = toUserId,
                });
            }
            catch (Exception e)
            {
                _logger.LogError(e, $"Can't create friend request, from:{fromUserId}, to:{toUserId}");
                toUser.FriendRequests.Remove(friendRequest);
                await _profileRepository.ReplaceOneAsync(toUser);
            }
        }
    }
}