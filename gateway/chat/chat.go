package chat

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/chatpb"
	"google.golang.org/grpc"
)

func NewChatService(conn *grpc.ClientConn) *chatpb.ChatServiceService {
	client := &chatService{
		client: chatpb.NewChatServiceClient(conn),
	}

	service := &chatpb.ChatServiceService{
		SendMessage:                      client.SendMessage,
		CreateRoom:                       client.CreateRoom,
		GetRoomsWhereUserIsParticipating: client.GetRoomsWhereUserIsParticipating,
		GetRoom:                          client.GetRoom,
	}

	return service
}

type chatService struct {
	client chatpb.ChatServiceClient
}

func (s *chatService) SendMessage(ctx context.Context, request *chatpb.SendMessageRequest) (*chatpb.SendMessageResponse, error) {
	return s.client.SendMessage(ctx, request)
}

func (s *chatService) CreateRoom(ctx context.Context, request *chatpb.CreateRoomRequest) (*chatpb.CreateRoomResponse, error) {
	return s.client.CreateRoom(ctx, request)
}

func (s *chatService) GetRoomsWhereUserIsParticipating(ctx context.Context, request *chatpb.GetRoomsWhereUserIsParticipatingRequest) (*chatpb.GetRoomsWhereUserIsParticipatingResponse, error) {
	return s.GetRoomsWhereUserIsParticipating(ctx, request)
}

func (s *chatService) GetRoom(ctx context.Context, request *chatpb.GetRoomRequest) (*chatpb.GetRoomResponse, error) {
	return s.client.GetRoom(ctx, request)
}
