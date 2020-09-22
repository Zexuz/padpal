using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Padel.Chat.Exceptions;
using Padel.Chat.Factories;
using Padel.Chat.Models;
using Padel.Chat.Repositories;
using Padel.Chat.Repositories.MongoDb;
using Padel.Chat.Services.Interface;
using Padel.Chat.ValueTypes;

namespace Padel.Chat.Services.Impl
{
    public class RoomService : IRoomService
    {
        private readonly IMongoRepository<Conversation> _conversationRepository;
        private readonly IRoomFactory                   _roomFactory;
        private readonly IRoomRepository                _roomRepository;
        private readonly IMessageSenderService          _messageSenderService;

        public RoomService(
            IMongoRepository<Conversation> conversationRepository,
            IRoomFactory                   roomFactory,
            IRoomRepository                roomRepository,
            IMessageSenderService          messageSenderService
        )
        {
            _conversationRepository = conversationRepository;
            _roomFactory = roomFactory;
            _roomRepository = roomRepository;
            _messageSenderService = messageSenderService;
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
                    coon = new Conversation {UserId = participant, MyChatRooms = new List<RoomId>{room.RoomId}};
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
            return await VerifyUsersAccessToRoom(userId, roomId);
        }
        
        public async Task<IReadOnlyCollection<ChatRoom>> GetRoomsWhereUserIsParticipant(UserId userId)
        {
            return await _roomRepository.GetRoomsWhereUsersIsParticipant(userId);
        }

        private async Task<ChatRoom> VerifyUsersAccessToRoom(UserId userId, RoomId roomId)
        {
            var room = await _roomRepository.GetRoom(roomId);
            if (room == null) // ROOM ID is null
            {
                throw new RoomNotFoundException(roomId);
            }

            if (room.Participants.All(id => id.Value != userId.Value))
            {
                throw new UserIsNotARoomParticipantException(userId);
            }

            return room;
        }
    }
}