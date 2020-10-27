using System.Collections.Generic;
using System.Threading.Tasks;
using Padel.Repository.Core.MongoDb;
using Padel.Social.Factories;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;

namespace Padel.Social.Services.Impl
{
    public class RoomService : IRoomService
    {
        private readonly IMongoRepository<Conversation> _conversationRepository;
        private readonly IRoomFactory                   _roomFactory;
        private readonly IRoomRepository                _roomRepository;
        private readonly IMessageSenderService          _messageSenderService;
        private readonly IVerifyRoomAccessService       _verifyRoomAccessService;

        public RoomService(
            IMongoRepository<Conversation> conversationRepository,
            IRoomFactory                   roomFactory,
            IRoomRepository                roomRepository,
            IMessageSenderService          messageSenderService,
            IVerifyRoomAccessService       verifyRoomAccessService
        )
        {
            _conversationRepository = conversationRepository;
            _roomFactory = roomFactory;
            _roomRepository = roomRepository;
            _messageSenderService = messageSenderService;
            _verifyRoomAccessService = verifyRoomAccessService;
        }

        public async Task<ChatRoom> CreateRoom(UserId adminUserId, string initMessage, IReadOnlyList<UserId> participants)
        {
            var room = _roomFactory.NewRoom(adminUserId, participants);
            await _roomRepository.InsertOneAsync(room);

            foreach (var participant in room.Participants)
            {
                var coon = await _conversationRepository.FindOneAsync(conversation => conversation.UserId.Equals(participant));

                if (coon == null)
                {
                    coon = new Conversation {UserId = participant, MyChatRooms = new List<RoomId> {room.RoomId}};
                    await _conversationRepository.InsertOneAsync(coon);
                    continue;
                }

                coon.MyChatRooms.Add(room.RoomId);

                await _conversationRepository.ReplaceOneAsync(coon);
            }

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
    }
}