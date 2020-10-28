using System;
using System.Collections.Generic;
using System.Linq;
using Padel.Social.Exceptions;
using Padel.Social.Models;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;

namespace Padel.Social.Factories
{
    public class RoomFactory : IRoomFactory
    {
        private readonly IGuidGeneratorService _guidGeneratorService;

        public RoomFactory(IGuidGeneratorService guidGeneratorService)
        {
            _guidGeneratorService = guidGeneratorService;
        }

        public ChatRoom NewRoom(UserId admin, IReadOnlyList<UserId> userIds)
        {
            var allParticipants = new List<Participant> {new Participant
            {
                UserId = admin,
                LastSeen = DateTimeOffset.UtcNow,
            }};
            
            allParticipants.AddRange(userIds.Select(id => new Participant
            {
                UserId = id,
                LastSeen = DateTimeOffset.MinValue,
            }).ToList());

            if (TryGetDuplicate(allParticipants, out var duplicate))
            {
                throw new ParticipantAlreadyAddedException(duplicate);
            }

            return new ChatRoom
            {
                Admin = admin,
                RoomId = new RoomId(_guidGeneratorService.GenerateNewId()),
                Messages = new List<Message>(),
                Participants = allParticipants
            };
        }

        private bool TryGetDuplicate(List<Participant> participants, out UserId duplicate)
        {
            duplicate = null;
            var hashSet = new HashSet<UserId>();

            foreach (var userId in participants.Select(t => t.UserId))
            {
                if (hashSet.Contains(userId))
                {
                    duplicate = userId;
                    return true;
                }

                hashSet.Add(userId);
            }

            return false;
        }
    }
}