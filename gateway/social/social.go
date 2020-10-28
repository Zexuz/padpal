package social

import (
	"context"
	"errors"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/protos/social_v1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
	"io"
	"log"
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
		ChangeProfilePicture:             client.ChangeProfilePicture,
		GetProfile:                       client.GetProfile,
		SubscribeToRoom:                  client.SubscribeToRoom,
		UpdateLastSeenInRoom:             client.UpdateLastSeenInRoom,
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

func (s *chatService) ChangeProfilePicture(ctx context.Context, request *socialpb.ChangeProfilePictureRequest) (*socialpb.ChangeProfilePictureResponse, error) {
	return s.pbClient.ChangeProfilePicture(ctx, request)
}

func (s *chatService) GetProfile(ctx context.Context, request *socialpb.GetProfileRequest) (*socialpb.GetProfileResponse, error) {
	return s.pbClient.GetProfile(ctx, request)
}

func (s *chatService) SubscribeToRoom(request *socialpb.SubscribeToRoomRequest, server socialpb.Social_SubscribeToRoomServer) error {
	ctx := server.Context()
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return errors.New("can't get ctx from incoming")
	}
	header := metadata.Pairs("padpal-user-id", md.Get("padpal-user-id")[0])
	ctx = metadata.NewOutgoingContext(ctx, header)

	microServiceStream, err := s.pbClient.SubscribeToRoom(ctx, request)

	if err != nil {
		log.Printf("Error subscribing to the microservice")
		return err
	}
	for {
		roomEvent, err := microServiceStream.Recv()
		if err == io.EOF {
			log.Printf("The microserice closed the connection")
			return microServiceStream.CloseSend()
		}
		if err != nil {
			log.Printf("Error receiving from microservice")
			return err
		}
		if err = server.Send(roomEvent); err != nil {
			log.Printf("error sending message to client")
			return err
		}
	}
}

func (s *chatService) UpdateLastSeenInRoom(ctx context.Context, request *socialpb.UpdateLastSeenInRoomRequest) (*socialpb.UpdateLastSeenInRoomResponse, error) {
	return s.pbClient.UpdateLastSeenInRoom(ctx, request)
}
