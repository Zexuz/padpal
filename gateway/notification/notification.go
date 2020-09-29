package notification

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/protos/notification_v1"
	"google.golang.org/grpc"
)

func NewNotificationService(conn *grpc.ClientConn) *noticitaionpb.NotificationService {
	client := &authService{
		client: noticitaionpb.NewNotificationClient(conn),
	}

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
