using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Padel.Proto.Social.V1;
using Padel.Social.Services.Interface;
using Padel.Social.ValueTypes;
using Message = Padel.Social.Models.Message;

namespace Padel.Social.Services.Impl
{
    public class RoomEventHandler : BackgroundService, IRoomEventHandler
    {
        private readonly IGuidGeneratorService                         _guidGeneratorService;
        private readonly IVerifyRoomAccessService                      _verifyRoomAccessService;
        private readonly ILogger<RoomEventHandler>                     _logger;
        private readonly IDictionary<string, IDictionary<string, Sub>> _cbs;
        private readonly TimeSpan                                      _maxConnectionTime;

        private readonly object _lock = new object();

        class Sub
        {
            public IAsyncStreamWriter<SubscribeToRoomResponse> AsyncStreamWriter { get; set; }
            public DateTimeOffset                              LastWrite         { get; set; }
        }

        public RoomEventHandler
        (
            IGuidGeneratorService     guidGeneratorService,
            IConfiguration            configuration,
            IVerifyRoomAccessService  verifyRoomAccessService,
            ILogger<RoomEventHandler> logger
        )
        {
            _guidGeneratorService = guidGeneratorService;
            _verifyRoomAccessService = verifyRoomAccessService;
            _cbs = new Dictionary<string, IDictionary<string, Sub>>();
            _logger = logger;
            _maxConnectionTime =
                TimeSpan.FromMinutes(int.TryParse(configuration["ROOM_EVENT_HANDLER:MAX_CONNECTION_TIME"], out var time) ? time : 10);
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                var subsToRemove = new Dictionary<string, List<string>>();
                lock (_lock)
                {
                    foreach (var (roomId, cb) in _cbs)
                    {
                        foreach (var (subId, writer) in cb)
                        {
                            if (DateTimeOffset.UtcNow - writer.LastWrite <= _maxConnectionTime) continue;

                            if (!subsToRemove.ContainsKey(roomId))
                            {
                                subsToRemove[roomId] = new List<string>();
                            }

                            subsToRemove[roomId].Add(subId);
                        }
                    }

                    foreach (var (roomId, subs) in subsToRemove)
                    {
                        var roomCbs = _cbs[roomId];
                        foreach (var (subId, _) in roomCbs)
                        {
                            if (!subs.Contains(subId)) continue;

                            _logger.LogInformation($"Removing id {subId}");
                            roomCbs.Remove(subId);
                            if (roomCbs.Count != 0) continue;
                            _cbs.Remove(roomId);
                            break;
                        }
                    }
                }

                _logger.LogDebug("Worker running at: {time}", DateTimeOffset.Now);
                await Task.Delay(TimeSpan.FromSeconds(1), stoppingToken);
            }
        }

        public async Task<string> SubscribeToRoom(int userId, string roomId, IAsyncStreamWriter<SubscribeToRoomResponse> callback)
        {
            await _verifyRoomAccessService.VerifyUsersAccessToRoom(new UserId(userId), new RoomId(roomId));
            var id = _guidGeneratorService.GenerateNewId();

            lock (_lock)
            {
                if (!_cbs.ContainsKey(roomId))
                {
                    _cbs[roomId] = new Dictionary<string, Sub>();
                }

                _cbs[roomId].Add(id, new Sub {LastWrite = DateTimeOffset.UtcNow, AsyncStreamWriter = callback});
            }

            return id;
        }

        public async Task EmitMessage(string roomId, Message message)
        {
            var messageToWrite = new SubscribeToRoomResponse
            {
                NewMessage = new Proto.Social.V1.Message
                {
                    Author = message.Author.Value,
                    Content = message.Content,
                    UtcTimestamp = message.Timestamp.ToUnixTimeMilliseconds()
                }
            };

            await WriteMessage(roomId, messageToWrite);
        }

        public async Task EmitNewLastSeen(int userId, string roomId)
        {
            var messageToWrite = new SubscribeToRoomResponse
            {
                LastSeenUpdated = new LastSeen
                {
                    Timestamp = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds(),
                    UserId = userId,
                }
            };

            await WriteMessage(roomId, messageToWrite);
        }

        public bool IsIdActive(string subId)
        {
            lock (_lock)
            {
                foreach (var writers in _cbs.Values)
                {
                    if (writers.ContainsKey(subId))
                        return true;
                }
            }

            return false;
        }


        private async Task WriteMessage(string roomId, SubscribeToRoomResponse messageToWrite)
        {
            lock (_lock)
            {
                if (!_cbs.ContainsKey(roomId)) return;
            }

            var writers = new List<KeyValuePair<string, Sub>>();
            lock (_lock)
            {
                writers.AddRange(_cbs[roomId]);
            }

            var terminatedSubIds = new List<string>();
            foreach (var (subId, sub) in writers)
            {
                try
                {
                    await sub.AsyncStreamWriter.WriteAsync(messageToWrite);
                }
                catch (Exception)
                {
                    terminatedSubIds.Add(subId);
                }
            }

            lock (_lock)
            {
                foreach (var subId in terminatedSubIds)
                {
                    _cbs[roomId].Remove(subId);
                }

                if (_cbs[roomId].Count == 0)
                {
                    _cbs.Remove(roomId);
                    return;
                }
            }
        }
    }
}