using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Exceptions;
using Padel.Social.Factories;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;

namespace Padel.Social.Services.Impl
{
    public class RoomService : IRoomService
    {
        private readonly IRoomFactory             _roomFactory;
        private readonly IRoomRepository          _roomRepository;
        private readonly IMessageSenderService    _messageSenderService;
        private readonly IVerifyRoomAccessService _verifyRoomAccessService;
        private readonly IRoomEventHandler        _roomEventHandler;

        public RoomService(
            IRoomFactory             roomFactory,
            IRoomRepository          roomRepository,
            IMessageSenderService    messageSenderService,
            IVerifyRoomAccessService verifyRoomAccessService,
            IRoomEventHandler        roomEventHandler
        )
        {
            _roomFactory = roomFactory;
            _roomRepository = roomRepository;
            _messageSenderService = messageSenderService;
            _verifyRoomAccessService = verifyRoomAccessService;
            _roomEventHandler = roomEventHandler;
        }

        public async Task<ChatRoom> CreateRoom(UserId adminUserId, string initMessage, IReadOnlyList<UserId> participants)
        {
            if (participants.Count == 1)
            {
                var toUser = participants[0].Value;
                var conversation = await _roomRepository.GetConversationBetweenUsers(adminUserId.Value, toUser);
                if (conversation.Any(chatRoom => chatRoom.Participants.Count == 2))
                {
                    throw new ConversationAlreadyExistsException(adminUserId.Value, toUser);
                }
            }

            var room = _roomFactory.NewRoom(adminUserId, participants);
            await _roomRepository.InsertOneAsync(room);

            await _messageSenderService.SendMessage(adminUserId, room, initMessage);
            return room;
        }

        public async Task<ChatRoom> GetRoom(UserId userId, RoomId roomId)
        {
            return await _verifyRoomAccessService.VerifyUsersAccessToRoom(userId, roomId);
        }

        public async Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId)
        {
            return await _roomRepository.GetRoomsWhereUsersIsParticipant(userId);
        }

        public async Task UpdateLastSeenInRoom(UserId userId, RoomId roomId)
        {
            var room = await _verifyRoomAccessService.VerifyUsersAccessToRoom(userId, roomId);

            var user = room.Participants.First(participant => Equals(participant.UserId, userId));
            user.LastSeen = DateTimeOffset.UtcNow;

            await _roomRepository.ReplaceOneAsync(room);

            await _roomEventHandler.EmitNewLastSeen(userId.Value, roomId.Value);
        }
    }
}