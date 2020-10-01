package chat

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/protos/chat_v1"
	"google.golang.org/grpc"
)

func NewChatService(conn *grpc.ClientConn) *chatpb.ChatServiceService {
	client := &chatService{
		pbClient: chatpb.NewChatServiceClient(conn),
	}

	err := hc.AddChecker("chat", conn)
	if err != nil {
		panic(err)
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
