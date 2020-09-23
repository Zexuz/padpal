using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Padel.Queue.Interface
{
    public interface IPublisher
    {
        public IReadOnlyList<IRegisteredEvent> Events { get; }
        Task                                   RegisterEvent(string name, Type type);
    }
}