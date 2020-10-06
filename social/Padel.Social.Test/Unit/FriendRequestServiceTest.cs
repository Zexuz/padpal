using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Proto.Social.V1;
using Padel.Queue;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Services.Impl;
using Padel.Test.Core;
using Xunit;
using Profile = Padel.Social.Models.Profile;

namespace Padel.Social.Test.Unit
{
    public class FriendRequestServiceTest
    {
        private readonly FriendRequestService      _sut;
        private readonly IMongoRepository<Profile> _fakeProfileRepository;
        private readonly IPublisher                _fakePublisher;

        public FriendRequestServiceTest()
        {
            _fakeProfileRepository = A.Fake<IMongoRepository<Profile>>();
            _fakePublisher = A.Fake<IPublisher>();

            _sut = TestHelper.ActivateWithFakes<FriendRequestService>(_fakeProfileRepository, _fakePublisher);
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

            A.CallTo(() => _fakeProfileRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(profile);

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

            A.CallTo(() => _fakeProfileRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(Task.FromResult<Profile>(null));

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

            A.CallTo(() => _fakeProfileRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(profile);

            var ex = await Assert.ThrowsAsync<AlreadyFriendsException>(() => _sut.SendFriendRequest(fromUser, toUser));
            Assert.Equal(fromUser, ex.FromUser);
            Assert.Equal(toUser, ex.ToUser);
        }

        [Fact]
        public async Task Should_create_friend_request()
        {
            var fromUser = 5;
            var toUser = 1337;

            await _sut.SendFriendRequest(fromUser, toUser);

            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>.That.Matches(profile =>
                    profile.FriendRequests.Count     == 1 &&
                    profile.FriendRequests[0].UserId == fromUser
                )
            )).MustHaveHappenedOnceExactly();

            A.CallTo(() => _fakePublisher.PublishMessage(
                A<FriendRequestReceived>.That.Matches(received =>
                    received.FromUser == fromUser && received.ToUser == toUser
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
                UserId = toUser,
                FriendRequests = new List<FriendRequest> {new FriendRequest {UserId = fromUser}}
            };

            A.CallTo(() => _fakeProfileRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(profile);

            await _sut.RespondToFriendRequest(fromUser, toUser, action);

            A.CallTo(() => _fakeProfileRepository.ReplaceOneAsync(A<Profile>.That.Matches(p =>
                    p.UserId               == toUser &&
                    p.Friends.Count        == 1      &&
                    p.FriendRequests.Count == 0      &&
                    p.Friends[0].UserId    == fromUser
                ))
            ).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakePublisher.PublishMessage(A<object>._)).MustHaveHappenedOnceExactly();
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

            A.CallTo(() => _fakeProfileRepository.FindOneAsync(A<Expression<Func<Profile, bool>>>._)).Returns(profile);

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