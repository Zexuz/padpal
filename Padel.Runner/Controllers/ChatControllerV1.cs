using System;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Padel.Proto.Chat.V1;

namespace Padel.Runner.Controllers
{
    [AllowAnonymous]
    public class ChatControllerV1 : ChatService.ChatServiceBase
    {
        private static Chat.ChatService _chatService = new Padel.Chat.ChatService();

        public ChatControllerV1()
        {
        }

        public override async Task<SendMessageResponse> SendMessage(SendMessageRequest request, ServerCallContext context)
        {
            await _chatService.SendMessage(4, request.Content);
            return new SendMessageResponse();
        }

        public override Task SubscribeToRoom(
            SubscribeToRoomRequest          request,
            IServerStreamWriter<RoomEvents> responseStream,
            ServerCallContext               context
        )
        {
            // Add user to chat room with a Func<Task, string>() that can be run when we wan to write the message back to all participants of that room
            
            _chatService.MessageReceived += async (sender, args) =>
            {
                var msg = new RoomEvents
                {
                    Message = new Message
                    {
                        Author = args.Message.Author.Value,
                        Content = args.Message.Content,
                        UtcTimestamp = args.Message.Timestamp.ToUnixTimeSeconds()
                    }
                };
                if (context.CancellationToken.IsCancellationRequested) Console.WriteLine("Request has been terminated");
                
                await responseStream.WriteAsync(msg);
            };
            while (true)
            {
                if (context.CancellationToken.IsCancellationRequested)
                {
                    return Task.CompletedTask;
                }
            }
        }
    }
}