namespace Padel.Chat.ValueTypes
{
    public abstract class ValueType<T> : ValueObject
    {
        public T Value { get; set; }

        protected ValueType(T value)
        {
            Value = value;
        }

        public abstract bool IsValid();
    }
}