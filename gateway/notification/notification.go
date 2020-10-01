package notification

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/protos/notification_v1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/status"
	"log"
	"time"
)

const serviceName = "notification"
const interval = 1 * time.Second

func NewNotificationService(conn *grpc.ClientConn, hs *health.Server) *noticitaionpb.NotificationService {
	client := &authService{
		client: noticitaionpb.NewNotificationClient(conn),
	}

	healthClient := grpc_health_v1.NewHealthClient(conn)
	hs.SetServingStatus(serviceName, grpc_health_v1.HealthCheckResponse_UNKNOWN)
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

	service := &noticitaionpb.NotificationService{
		AppendFcmTokenToUser: client.AppendFcmTokenToUser,
	}

	return service
}

type authService struct {
	client noticitaionpb.NotificationClient
}

func (c *authService) AppendFcmTokenToUser(ctx context.Context, request *noticitaionpb.AppendFcmTokenToUserRequest) (*noticitaionpb.AppendFcmTokenToUserResponse, error) {
	return c.client.AppendFcmTokenToUser(ctx, request)
}
