using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Queue
{
    public interface IPublisher
    {
        public IReadOnlyList<IRegisteredEvent> Events { get; }
        Task                                   RegisterEvent(string  name, Type type);
        Task                                   PublishMessage(object message);
    }
}