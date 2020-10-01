package auth

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/protos/auth_v1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/status"
	"log"
	"time"
)

const serviceName = "identity"
const interval = 1 * time.Second

func NewAuthService(conn *grpc.ClientConn, hs *health.Server) *authpb.AuthServiceService {
	client := &authService{
		client: authpb.NewAuthServiceClient(conn),
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

	service := &authpb.AuthServiceService{
		SignUp:            client.SignUp,
		SignIn:            client.SignIn,
		GetNewAccessToken: client.GetNewAccessToken,
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
