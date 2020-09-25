using System.Collections.Generic;
using System.Threading.Tasks;
using Grpc.Core;
using MongoDB.Bson;
using Padel.Grpc.Core;
using Padel.Proto.Notification.V1;
using Padel.Repository.Core.MongoDb;

namespace Padel.Notification.Runner.Controllers
{
    public class NotificationServiceRepoModel : IDocument
    {
        public ObjectId     Id        { get; set; }
        public int          UserId    { get; set; }
        public List<string> FCMTokens { get; set; }
    }

    public class NotificationControllerV1 : Proto.Notification.V1.Notification.NotificationBase
    {
        private readonly IMongoRepository<NotificationServiceRepoModel> _mongoRepository;

        public NotificationControllerV1(IMongoRepository<NotificationServiceRepoModel> mongoRepository)
        {
            _mongoRepository = mongoRepository;
        }

        public override async Task<AppendFcmTokenToUserResponse> AppendFcmTokenToUser(AppendFcmTokenToUserRequest request, ServerCallContext context)
        {
            var userId = context.GetUserId();

            if (string.IsNullOrWhiteSpace(request.FcmToken))
            {
                var metadata = new Metadata {{"padpal-error", "fcm token is invalid"}};
                throw new RpcException(new Status(StatusCode.InvalidArgument, nameof(request.FcmToken)), metadata);
            }

            var repoModel = await _mongoRepository.FindOneAsync(model => model.UserId == userId);
            if (repoModel == null)
            {
                await _mongoRepository.InsertOneAsync(new NotificationServiceRepoModel
                {
                    UserId = userId,
                    FCMTokens = new List<string> {request.FcmToken}
                });
            }
            else
            {
                repoModel.FCMTokens.Add(request.FcmToken);
                await _mongoRepository.ReplaceOneAsync(repoModel);
            }

            return new AppendFcmTokenToUserResponse();
        }
    }
}