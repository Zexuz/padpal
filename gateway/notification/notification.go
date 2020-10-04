package notification

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/protos/notification_v1"
	"google.golang.org/grpc"
)

func NewNotificationService(conn *grpc.ClientConn) *noticitaionpb.NotificationService {
	client := &authService{
		client: noticitaionpb.NewNotificationClient(conn),
	}

	err := hc.AddChecker("notification", conn)
	if err != nil {
		panic(err)
	}

	service := &noticitaionpb.NotificationService{
		AppendFcmTokenToUser: client.AppendFcmTokenToUser,
		GetNotification:      client.GetNotification,
		RemoveNotification:   client.RemoveNotification,
	}

	return service
}

type authService struct {
	client noticitaionpb.NotificationClient
}

func (c *authService) AppendFcmTokenToUser(ctx context.Context, request *noticitaionpb.AppendFcmTokenToUserRequest) (*noticitaionpb.AppendFcmTokenToUserResponse, error) {
	return c.client.AppendFcmTokenToUser(ctx, request)
}

func (c *authService) GetNotification(ctx context.Context, request *noticitaionpb.GetNotificationRequest) (*noticitaionpb.GetNotificationResponse, error) {
	return c.client.GetNotification(ctx, request)
}

func (c *authService) RemoveNotification(ctx context.Context, request *noticitaionpb.RemoveNotificationRequest) (*noticitaionpb.RemoveNotificationResponse, error) {
	return c.client.RemoveNotification(ctx, request)
}
