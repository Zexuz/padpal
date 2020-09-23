package auth

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/authpb"
	"google.golang.org/grpc"
)

func NewAuthService(conn *grpc.ClientConn) *authpb.AuthServiceService {
	client := &authService{
		client: authpb.NewAuthServiceClient(conn),
	}

	service := &authpb.AuthServiceService{
		Register:          client.Register,
		SignIn:            client.SignIn,
		GetNewAccessToken: client.GetNewAccessToken,
	}

	return service
}

type authService struct {
	client authpb.AuthServiceClient
}

func (c *authService) Register(ctx context.Context, request *authpb.RegisterRequest) (*authpb.RegisterResponse, error) {
	return c.client.Register(ctx, request)
}
func (c *authService) SignIn(ctx context.Context, request *authpb.SignInRequest) (*authpb.SignInResponse, error) {
	return c.client.SignIn(ctx, request)
}
func (c *authService) GetNewAccessToken(ctx context.Context, request *authpb.GetNewAccessTokenRequest) (*authpb.GetNewAccessTokenResponse, error) {
	return c.client.GetNewAccessToken(ctx, request)
}
