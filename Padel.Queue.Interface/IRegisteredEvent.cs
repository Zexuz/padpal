using System;

namespace Padel.Queue.Interface
{
    public interface IRegisteredEvent
    {
        Type   Type { get; set; }
        string Name { get; set; }
    }
}