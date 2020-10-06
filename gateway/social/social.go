package social

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/protos/social_v1"
	"google.golang.org/grpc"
)

func NewSocialService(conn *grpc.ClientConn) *socialpb.SocialService {
	client := &chatService{
		pbClient: socialpb.NewSocialClient(conn),
	}

	err := hc.AddChecker("social", conn)
	if err != nil {
		panic(err)
	}

	service := &socialpb.SocialService{
		SendMessage:                      client.SendMessage,
		CreateRoom:                       client.CreateRoom,
		GetRoomsWhereUserIsParticipating: client.GetRoomsWhereUserIsParticipating,
		GetRoom:                          client.GetRoom,
		SearchForProfile:                 client.SearchForProfile,
		SendFriendRequest:                client.SendFriendRequest,
		RespondToFriendRequest:           client.RespondToFriendRequest,
		MyProfile:                        client.MyProfile,
	}

	return service
}

type chatService struct {
	pbClient socialpb.SocialClient
}

func (s *chatService) SendMessage(ctx context.Context, request *socialpb.SendMessageRequest) (*socialpb.SendMessageResponse, error) {
	return s.pbClient.SendMessage(ctx, request)
}

func (s *chatService) CreateRoom(ctx context.Context, request *socialpb.CreateRoomRequest) (*socialpb.CreateRoomResponse, error) {
	return s.pbClient.CreateRoom(ctx, request)
}

func (s *chatService) GetRoomsWhereUserIsParticipating(ctx context.Context, request *socialpb.GetRoomsWhereUserIsParticipatingRequest) (*socialpb.GetRoomsWhereUserIsParticipatingResponse, error) {
	return s.pbClient.GetRoomsWhereUserIsParticipating(ctx, request)
}

func (s *chatService) GetRoom(ctx context.Context, request *socialpb.GetRoomRequest) (*socialpb.GetRoomResponse, error) {
	return s.pbClient.GetRoom(ctx, request)
}

func (s *chatService) SearchForProfile(ctx context.Context, request *socialpb.SearchForProfileRequest) (*socialpb.SearchForProfileResponse, error) {
	return s.pbClient.SearchForProfile(ctx, request)
}

func (s *chatService) RespondToFriendRequest(ctx context.Context, request *socialpb.RespondToFriendRequestRequest) (*socialpb.RespondToFriendRequestResponse, error) {
	return s.pbClient.RespondToFriendRequest(ctx, request)
}

func (s *chatService) SendFriendRequest(ctx context.Context, request *socialpb.SendFriendRequestRequest) (*socialpb.SendFriendRequestResponse, error) {
	return s.pbClient.SendFriendRequest(ctx, request)
}

func (s *chatService) MyProfile(ctx context.Context, request *socialpb.MyProfileRequest) (*socialpb.MyProfileResponse, error) {
	return s.pbClient.MyProfile(ctx, request)
}
