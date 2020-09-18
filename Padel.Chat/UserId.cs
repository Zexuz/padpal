namespace Padel.Chat
{
    public class UserId : ValueType<int>
    {
        public UserId(in int userId) : base(userId)
        {
        }

        public override bool IsValid()
        {
            return Value > 0;
        }
    }
}