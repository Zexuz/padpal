namespace Padel.Notification
{
    public abstract class PushNotification<T>
    {
        public string MessageType { get; }
        public T      Message     { get; }

        protected PushNotification(string messageType, T message)
        {
            MessageType = messageType;
            Message = message;
        }
    }
}