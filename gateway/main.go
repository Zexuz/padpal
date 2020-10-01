package main

import (
	"flag"
	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/mkdir-sweden/padpal/gateway/auth"
	"github.com/mkdir-sweden/padpal/gateway/chat"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/interceptors"
	"github.com/mkdir-sweden/padpal/gateway/notification"
	authpb "github.com/mkdir-sweden/padpal/gateway/protos/auth_v1"
	chatpb "github.com/mkdir-sweden/padpal/gateway/protos/chat_v1"
	noticitaionpb "github.com/mkdir-sweden/padpal/gateway/protos/notification_v1"
	"github.com/soheilhy/cmux"
	"github.com/unrolled/render"
	"golang.org/x/sync/errgroup"
	"google.golang.org/grpc"
	_ "google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/reflection"
	_ "google.golang.org/protobuf/types/descriptorpb"
	"log"
	"net"
	"net/http"
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

	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	m := cmux.New(lis)
	grpcListener := m.Match(cmux.HTTP2HeaderField("content-type", "application/grpc"))
	httpListener := m.Match(cmux.HTTP1Fast())

	g := new(errgroup.Group)
	g.Go(func() error { return grpcServe(grpcListener) })
	g.Go(func() error { return httpServe(httpListener) })
	g.Go(func() error { return m.Serve() })

	log.Println("run server: ", g.Wait())
}

func httpServe(listener net.Listener) error {
	ren := render.New()

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		ren.JSON(w, 200, hc.GetAllRegisteredService())
	})

	server := &http.Server{Handler: r}
	return server.Serve(listener)
}

func grpcServe(lis net.Listener) error {
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

	s := grpc.NewServer(serverOps...)

	reflection.Register(s)
	grpc_health_v1.RegisterHealthServer(s, hc.HealthServer)
	chatpb.RegisterChatServiceService(s, chat.NewChatService(chatConn))
	authpb.RegisterAuthServiceService(s, auth.NewAuthService(authConn))
	noticitaionpb.RegisterNotificationService(s, notification.NewNotificationService(notifiConn))
	log.Println("Servning...")
	return s.Serve(lis)
}
