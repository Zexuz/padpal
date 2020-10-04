using System;
using System.Collections.Generic;

namespace Padel.Social.ValueTypes
{
    public class RoomId : ValueType<string>
    {
        public RoomId(string roomId) : base(roomId)
        {
        }

        public override bool IsValid()
        {
            return Guid.TryParse(Value, out _);
        }

        protected override IEnumerable<object> GetEqualityComponents()
        {
            yield return Value;
        }
    }
}