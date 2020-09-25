using System;

namespace Padel.Queue
{
    public interface IRegisteredEvent
    {
        Type   Type { get; set; }
        string Name { get; set; }
    }
}