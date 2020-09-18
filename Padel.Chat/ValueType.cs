namespace Padel.Chat
{
    public abstract class ValueType<T>
    {
        public T Value { get; }

        protected ValueType(T value)
        {
            Value = value;
        }

        public abstract bool IsValid();
    }
}