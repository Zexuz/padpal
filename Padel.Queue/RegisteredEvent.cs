using System;
using Amazon.SimpleNotificationService.Model;
using Padel.Queue.Interface;

namespace Padel.Queue
{
    internal class RegisteredEvent : IRegisteredEvent
    {
        public Type   Type { get; set; }
        public string Name { get; set; }
        public Topic  Arn  { get; set; }
    }
}