using System;
using Padel.Social.ValueTypes;

namespace Padel.Social.Exceptions
{
    public class RoomNotFoundException : Exception
    {
        public RoomId RoomId { get; }

        public RoomNotFoundException(RoomId roomId)
        {
            RoomId = roomId;
        }
    }
}