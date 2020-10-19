using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Test.Unit
{
    public class FriendRequestServiceTest
    {
        private readonly FriendRequestService _sut;
        private readonly IProfileRepository   _fakeProfileRepository;
        private readonly IPublisher           _fakePublisher;

        public FriendRequestServiceTest()
        {
            _fakeProfileRepository = A.Fake<IProfileRepository>();
            _fakePublisher = A.Fake<IPublisher>();

            _sut = TestHelper.ActivateWithFakes<FriendRequestService>(_fakeProfileRepository, _fakePublisher);
        }

        [Fact]
        public async Task Should_throw_trying_to_add_myself()
        {
            var fromUser = 5;
            var toUser = 5;

            await Assert.ThrowsAsync<ArgumentException>(() => _sut.SendFriendRequest(fromUser, toUser));
        }

        [Fact]
        public async Task Should_throw_if_friendRequest_already_exists()
        {
            var fromUser = 5;
            var toUser = 1337;

            var profile = new Profile
            {
                FriendRequests = new List<FriendRequest> {new FriendRequest {UserId = fromUser}}
            };

            A.CallTo(() => _fakeProfileRepository.FindByUserId(A<int>._)).Returns(profile);

            var ex = await Assert.ThrowsAsync<FriendRequestAlreadyExistsException>(() => _sut.SendFriendRequest(fromUser, toUser));
            Assert.Equal(fromUser, ex.FromUser);
            Assert.Equal(toUser, ex.ToUser);

            A.CallTo(() => _fakePublisher.PublishMessage(A<object>._)).MustNotHaveHappened();
            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_throw_if_user_does_not_exists()
        {
            var fromUser = 5;
            var toUser = 1337;

            A.CallTo(() => _fakeProfileRepository.FindByUserId(A<int>._)).Returns(null);

            var ex = await Assert.ThrowsAsync<UserDoesNotExistsException>(() => _sut.SendFriendRequest(fromUser, toUser));
            Assert.Equal(toUser, ex.User);

            A.CallTo(() => _fakePublisher.PublishMessage(A<object>._)).MustNotHaveHappened();
            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_throw_if_already_friends()
        {
            var fromUser = 5;
            var toUser = 1337;

            var profile = new Profile
            {
                Friends = new List<Friend> {new Friend {UserId = fromUser}}
            };

            A.CallTo(() => _fakeProfileRepository.FindByUserId(A<int>._)).Returns(profile);

            var ex = await Assert.ThrowsAsync<AlreadyFriendsException>(() => _sut.SendFriendRequest(fromUser, toUser));
            Assert.Equal(fromUser, ex.FromUser);
            Assert.Equal(toUser, ex.ToUser);
        }

        [Fact]
        public async Task Should_create_friend_request()
        {
            var fromUserId = 5;
            var fromUserName = "kalle";
            var toUser = 1337;

            A.CallTo(() => _fakeProfileRepository.FindByUserId(5)).Returns(new Profile
            {
                Name = fromUserName,
                PictureUrl = "somePicture",
                UserId = fromUserId,
            });

            await _sut.SendFriendRequest(fromUserId, toUser);

            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>.That.Matches(profile =>
                    profile.FriendRequests.Count     == 1 &&
                    profile.FriendRequests[0].UserId == fromUserId
                )
            )).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakePublisher.PublishMessage(
                A<FriendRequestReceived>.That.Matches(received =>
                    received.FromUser.UserId == fromUserId &&
                    received.FromUser.Name   == fromUserName
                    && received.ToUser       == toUser
                )
            )).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_handle_accept_action()
        {
            var fromUser = 5;
            var toUser = 1337;
            var action = RespondToFriendRequestRequest.Types.Action.Accept;

            var profile = new Profile
            {
                Name = "kalle anka",
                UserId = toUser,
                FriendRequests = new List<FriendRequest> {new FriendRequest {UserId = fromUser}}
            };

            var fromProfile = new Profile
            {
                Name = "donald duck",
                UserId = fromUser,
            };

            A.CallTo(() => _fakeProfileRepository.FindByUserId(toUser)).Returns(profile);
            A.CallTo(() => _fakeProfileRepository.FindByUserId(fromUser)).Returns(fromProfile);

            await _sut.RespondToFriendRequest(fromUser, toUser, action);

            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>.That.Matches(p =>
                    p.UserId               == toUser &&
                    p.Friends.Count        == 1      &&
                    p.FriendRequests.Count == 0      &&
                    p.Friends[0].UserId    == fromUser
                ))
            ).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>.That.Matches(p =>
                    p.UserId               == fromUser &&
                    p.Friends.Count        == 1        &&
                    p.FriendRequests.Count == 0        &&
                    p.Friends[0].UserId    == toUser
                ))
            ).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakePublisher.PublishMessage(A<FriendRequestAccepted>.That.Matches(request =>
                    request.UserThatAccepted.Name   == profile.Name   &&
                    request.UserThatAccepted.UserId == profile.UserId &&
                    request.UserThatRequested       == fromUser
                )
            )).MustHaveHappenedOnceExactly();
        }

        [Fact]
        public async Task Should_handle_decline_action()
        {
            var fromUser = 5;
            var toUser = 1337;
            var action = RespondToFriendRequestRequest.Types.Action.Decline;

            var profile = new Profile
            {
                UserId = toUser,
                FriendRequests = new List<FriendRequest> {new FriendRequest {UserId = fromUser}}
            };

            A.CallTo(() => _fakeProfileRepository.FindByUserId(toUser)).Returns(profile);

            await _sut.RespondToFriendRequest(fromUser, toUser, action);

            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>.That.Matches(p =>
                    p.UserId               == toUser &&
                    p.Friends.Count        == 0      &&
                    p.FriendRequests.Count == 0
                ))
            ).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakePublisher.PublishMessage(A<object>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_throw_if_no_matching_friendRequest_exists()
        {
            var fromUser = 5;
            var toUser = 1337;
            var action = RespondToFriendRequestRequest.Types.Action.Accept;

            var profile = new Profile { };

            A.CallTo(() => _fakeProfileRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(profile);

            var ex = await Assert.ThrowsAsync<NoMatchingFriendRequestFoundException>(() => _sut.RespondToFriendRequest(fromUser, toUser, action));
            Assert.Equal(fromUser, ex.FromUser);
            Assert.Equal(toUser, ex.ToUser);
        }

        [Fact]
        public async Task Should_throw_if_action_is_unknown()
        {
            var fromUser = 5;
            var toUser = 1337;
            var action = RespondToFriendRequestRequest.Types.Action.Unknown;

            await Assert.ThrowsAsync<ArgumentException>(() => _sut.RespondToFriendRequest(fromUser, toUser, action));
        }
    }
}