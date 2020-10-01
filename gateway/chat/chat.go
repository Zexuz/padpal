package chat

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/protos/chat_v1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/status"
	"log"
	"time"
)

const serviceName = "chat"
const interval = 1 * time.Second

func NewChatService(conn *grpc.ClientConn, hs *health.Server) *chatpb.ChatServiceService {
	client := &chatService{
		pbClient: chatpb.NewChatServiceClient(conn),
	}

	healthClient := grpc_health_v1.NewHealthClient(conn)
	go func() {
		for {
			res, err := healthClient.Check(context.Background(), &grpc_health_v1.HealthCheckRequest{
				Service: "",
			})
			if err != nil {
				if stat, ok := status.FromError(err); ok && stat.Code() == codes.Unimplemented {
					log.Printf("the service %s doesn't implement the grpc health protocol\n", serviceName)
				} else {
					log.Printf("rpc failed %s", err)
					hs.SetServingStatus(serviceName, grpc_health_v1.HealthCheckResponse_NOT_SERVING)
				}
			} else {
				hs.SetServingStatus(serviceName, res.Status)
			}
			time.Sleep(interval)
		}
	}()

	service := &chatpb.ChatServiceService{
		SendMessage:                      client.SendMessage,
		CreateRoom:                       client.CreateRoom,
		GetRoomsWhereUserIsParticipating: client.GetRoomsWhereUserIsParticipating,
		GetRoom:                          client.GetRoom,
	}

	return service
}

type chatService struct {
	pbClient chatpb.ChatServiceClient
}

func (s *chatService) SendMessage(ctx context.Context, request *chatpb.SendMessageRequest) (*chatpb.SendMessageResponse, error) {
	return s.pbClient.SendMessage(ctx, request)
}

func (s *chatService) CreateRoom(ctx context.Context, request *chatpb.CreateRoomRequest) (*chatpb.CreateRoomResponse, error) {
	return s.pbClient.CreateRoom(ctx, request)
}

func (s *chatService) GetRoomsWhereUserIsParticipating(ctx context.Context, request *chatpb.GetRoomsWhereUserIsParticipatingRequest) (*chatpb.GetRoomsWhereUserIsParticipatingResponse, error) {
	return s.pbClient.GetRoomsWhereUserIsParticipating(ctx, request)
}

func (s *chatService) GetRoom(ctx context.Context, request *chatpb.GetRoomRequest) (*chatpb.GetRoomResponse, error) {
	return s.pbClient.GetRoom(ctx, request)
}
