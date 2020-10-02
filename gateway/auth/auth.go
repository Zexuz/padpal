package auth

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/protos/auth_v1"
	"google.golang.org/grpc"
)

func NewAuthService(conn *grpc.ClientConn) *authpb.AuthServiceService {
	client := &authService{
		client: authpb.NewAuthServiceClient(conn),
	}

	err := hc.AddChecker("identity", conn)
	if err != nil {
		panic(err)
	}

	service := &authpb.AuthServiceService{
		SignUp:            client.SignUp,
		SignIn:            client.SignIn,
		GetNewAccessToken: client.GetNewAccessToken,
		GetPublicJwtKey:   client.GetPublicJwtKey,
	}

	return service
}

type authService struct {
	client authpb.AuthServiceClient
}

func (c *authService) SignUp(ctx context.Context, request *authpb.SignUpRequest) (*authpb.SignUpResponse, error) {
	return c.client.SignUp(ctx, request)
}
func (c *authService) SignIn(ctx context.Context, request *authpb.SignInRequest) (*authpb.SignInResponse, error) {
	return c.client.SignIn(ctx, request)
}
func (c *authService) GetNewAccessToken(ctx context.Context, request *authpb.GetNewAccessTokenRequest) (*authpb.GetNewAccessTokenResponse, error) {
	return c.client.GetNewAccessToken(ctx, request)
}

func (c *authService) GetPublicJwtKey(ctx context.Context, request *authpb.GetPublicJwtKeyRequest) (*authpb.GetPublicJwtKeyResponse, error) {
	return c.client.GetPublicJwtKey(ctx, request)
}
