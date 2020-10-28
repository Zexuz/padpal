using System.Linq;
using System.Threading.Tasks;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Repositories;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;

namespace Padel.Social.Services.Impl
{
    public class VerifyRoomAccessService : IVerifyRoomAccessService
    {
        private readonly IRoomRepository _roomRepository;

        public VerifyRoomAccessService(IRoomRepository roomRepository)
        {
            _roomRepository = roomRepository;
        }

        public async Task<ChatRoom> VerifyUsersAccessToRoom(UserId userId, RoomId roomId)
        {
            var room = await _roomRepository.GetRoom(roomId);
            if (room == null) // ROOM ID is null
            {
                throw new RoomNotFoundException(roomId);
            }

            if (room.Participants.All(p => p.UserId.Value != userId.Value))
            {
                throw new UserIsNotARoomParticipantException(userId);
            }

            return room;
        }
    }
}