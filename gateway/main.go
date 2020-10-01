package main

import (
	"flag"
	"github.com/mkdir-sweden/padpal/gateway/auth"
	"github.com/mkdir-sweden/padpal/gateway/chat"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/interceptors"
	"github.com/mkdir-sweden/padpal/gateway/notification"
	authpb "github.com/mkdir-sweden/padpal/gateway/protos/auth_v1"
	chatpb "github.com/mkdir-sweden/padpal/gateway/protos/chat_v1"
	noticitaionpb "github.com/mkdir-sweden/padpal/gateway/protos/notification_v1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/health"
	_ "google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/reflection"
	_ "google.golang.org/protobuf/types/descriptorpb"
	"log"
	"net"
	"os"
)

const (
	port = ":50051"
)

func getEnvOrDefault(name, def string) string {
	value, found := os.LookupEnv(name)
	if !found {
		return def
	}
	return value
}

func main() {
	flag.Parse()
	var opts []grpc.DialOption
	var serverOps []grpc.ServerOption
	opts = append(opts, grpc.WithInsecure())
	serverOps = append(serverOps, interceptors.WithJwtValidationUnaryInterceptor())

	log.Println("starting...")
	chatConn, err := grpc.Dial(getEnvOrDefault("CHAT_ADDRESS", "localhost:5001"), opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer chatConn.Close()

	authConn, err := grpc.Dial(getEnvOrDefault("IDENTITY_ADDRESS", "localhost:5002"), opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer authConn.Close()

	notifiConn, err := grpc.Dial(getEnvOrDefault("NOTIFICATION_ADDRESS", "localhost:5003"), opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer notifiConn.Close()

	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer(serverOps...)

	hs := health.NewServer()
	hc.HealthServer = hs
	reflection.Register(s)
	grpc_health_v1.RegisterHealthServer(s, hs)
	chatpb.RegisterChatServiceService(s, chat.NewChatService(chatConn))
	authpb.RegisterAuthServiceService(s, auth.NewAuthService(authConn))
	noticitaionpb.RegisterNotificationService(s, notification.NewNotificationService(notifiConn))
	log.Println("Servning...")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
