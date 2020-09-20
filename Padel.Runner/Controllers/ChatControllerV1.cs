using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FirebaseAdmin;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Padel.Chat.old;
using Padel.Chat.ValueTypes;
using Padel.Proto.Chat.V1;
using ChatService = Padel.Proto.Chat.V1.ChatService;
using Message = Padel.Proto.Chat.V1.Message;

namespace Padel.Runner.Controllers
{
    [AllowAnonymous]
    public class ChatControllerV1 : ChatService.ChatServiceBase
    {
        private readonly IRepository<ChatRoomModel, string> _repository;
        private readonly FirebaseApp                        _firebaseApp;
        private static   Chat.old.ChatService               _chatService      = new Chat.old.ChatService();
        private static   ChatRoomNofifier                   _chatRoomNofifier = new ChatRoomNofifier();

        public ChatControllerV1(IRepository<ChatRoomModel, string> repository, FirebaseApp firebaseApp)
        {
            _repository = repository;
            _firebaseApp = firebaseApp;
        }

        const string roomId = "ROOM_ID";

        public override async Task<SendMessageResponse> SendMessage(SendMessageRequest request, ServerCallContext context)
        {
            var userId = 4;
            await _chatService.SendMessage(4, request.Content);

            var room = await _repository.GetAsync(roomId);

            if (room == null)
            {
                room = new ChatRoomModel
                {
                    Id = roomId
                };
            }

            room.Messages.Add(new Chat.old.Message
            {
                Author = new UserId(userId),
                Content = request.Content,
                Timestamp = DateTimeOffset.UtcNow
            });

            await _repository.SaveAsync(room);
            await new PushNotificationService().SendMessage(request.Content);
            // TODO
            // Here we should send a push notification 
            // To all the participants

            // Steps to achieve it
            // 1. Rename the RefreshToken SQL table to Device
            // 2. Add a new column called FCM_TOKEN (Follow naming conventions)
            // 3. Send the FCM token when the user logins
            // 4. Here we should look in the room to see who the participants are.
            // 5. Get all their FCM tokens
            // 6. Loop over the FCM tokens and send push notifications

            return new SendMessageResponse();
        }

        // When we send a message p2p. We have a separate grpc endpoint for that. 
        // SendMessageP2P(string message, int toUserId)
        // It will check if the two are friends. (To be implemented later)
        // If will check in 'Conversation' collection if there is a chatRoom with the id of the p2p room

        // Ignore the above. If we have a set of rules to generate p2p room ids on the backend, we could implement that logic on the frontend for "creating" room. (But now we have backend logic in or app)

        // We could have a endpoint 'GetRoomIdForP2P(int userId):string, error', it returns error when we are not allow to chat with that person.
        // It return a roomId that than can be used to with SendMessageToRoom(roomId, message). If the roomId does not exists yet, we add it. b/c we already know that this is a valid roomid.rrrrrrrrrrrrrr 

        // Create a collection that keeps track of what conversations that you are currently participating in
        public class Conversation
        {
            public int          UserId      { get; set; }
            public List<string> MyChatRooms { get; set; } // List of all the rooms that I am participating in.
        }


        public override async Task<GetMessagesResponse> GetMessages(GetMessagesRequest request, ServerCallContext context)
        {
            var room = await _repository.GetAsync(roomId);

            return new GetMessagesResponse
            {
                Messages =
                {
                    room.Messages.Select(message => new Message
                    {
                        Author = message.Author.Value,
                        Content = message.Content,
                        UtcTimestamp = message.Timestamp.ToUnixTimeSeconds()
                    }).ToList()
                }
            };
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