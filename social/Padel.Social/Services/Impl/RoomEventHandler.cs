using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.Extensions.Logging;
using Padel.Proto.Social.V1;
using Padel.Social.Services.Interface;
using Message = Padel.Social.Models.Message;

namespace Padel.Social.Services.Impl
{
    // public class RoomEventHandler : BackgroundService
    public class RoomEventHandler : IRoomEventHandler
    {
        private readonly ILogger<RoomEventHandler>                                                       _logger;
        private readonly ConcurrentDictionary<string, List<IAsyncStreamWriter<SubscribeToRoomResponse>>> _callbacks;

        public RoomEventHandler(ILogger<RoomEventHandler> logger)
        {
            _logger = logger;
            _callbacks = new ConcurrentDictionary<string, List<IAsyncStreamWriter<SubscribeToRoomResponse>>>();
        }

        public void SubscribeToRoom(string roomId, IAsyncStreamWriter<SubscribeToRoomResponse> callback)
        {
            if (!_callbacks.ContainsKey(roomId))
            {
                _callbacks[roomId] = new List<IAsyncStreamWriter<SubscribeToRoomResponse>>();
            }

            _callbacks[roomId].Add(callback);
        }

        public async Task EmitMessage(string roomId, Message message)
        {
            if (!_callbacks.ContainsKey(roomId))
            {
                return;
            }


            foreach (var callback in _callbacks[roomId])
            {
                try
                {
                    await callback.WriteAsync(new SubscribeToRoomResponse
                    {
                        NewMessage = new Proto.Social.V1.Message
                        {
                            Author = message.Author.Value,
                            Content = message.Content,
                            UtcTimestamp = message.Timestamp.ToUnixTimeSeconds()
                        }
                    });
                }
                catch (Exception)
                {
                    _logger.LogWarning($"Could not write to callbacks in room {roomId}, should close and delete this connection now");
                    throw;
                }
            }
        }

        // protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        // {
        //     // TODO check periodical if we should close the connection
        //     while (!stoppingToken.IsCancellationRequested)
        //     {
        //         _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
        //         await Task.Delay(1000, stoppingToken);
        //     }
        // }
    }
}