package main

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/chatpb"
	"google.golang.org/grpc"
	"log"
	"net"
)

const (
	port = ":50051"
)

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	g := newGateway()

	chatpb.RegisterChatServiceService(s, g.ChatService())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}

//https://github.com/grpc/grpc-go/blob/4e932bbcb079d1fc8cdfe8a62adca81fe1371165/examples/route_guide/server/server.go#L56
type gatewayServer struct {
	chatService *chatService
}

func newGateway() *gatewayServer {
	s := &gatewayServer{
		&chatService{},
	}
	return s
}

func (s *gatewayServer) ChatService() *chatpb.ChatServiceService {
	return &chatpb.ChatServiceService{
		SendMessage:                      s.chatService.SendMessage,
		CreateRoom:                       s.chatService.CreateRoom,
		GetRoomsWhereUserIsParticipating: s.chatService.GetRoomsWhereUserIsParticipating,
		GetRoom:                          s.chatService.GetRoom,
	}
}

type chatService struct {
	// TODO props needed
}

func (s *chatService) SendMessage(ctx context.Context, request *chatpb.SendMessageRequest) (*chatpb.SendMessageResponse, error) {
	return nil, nil
}
func (s *chatService) CreateRoom(ctx context.Context, request *chatpb.CreateRoomRequest) (*chatpb.CreateRoomResponse, error) {
	return nil, nil
}

func (s *chatService) GetRoomsWhereUserIsParticipating(ctx context.Context, request *chatpb.GetRoomsWhereUserIsParticipatingRequest) (*chatpb.GetRoomsWhereUserIsParticipatingResponse, error) {
	return nil, nil
}

func (s *chatService) GetRoom(ctx context.Context, request *chatpb.GetRoomRequest) (*chatpb.GetRoomResponse, error) {
	return &chatpb.GetRoomResponse{}, nil
}
