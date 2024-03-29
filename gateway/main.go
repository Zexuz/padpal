package main

import (
	"context"
	"flag"
	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/mkdir-sweden/padpal/gateway/auth"
	"github.com/mkdir-sweden/padpal/gateway/game"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/interceptors"
	"github.com/mkdir-sweden/padpal/gateway/notification"
	authpb "github.com/mkdir-sweden/padpal/gateway/protos/auth_v1"
	gamepb "github.com/mkdir-sweden/padpal/gateway/protos/game_v1"
	noticitaionpb "github.com/mkdir-sweden/padpal/gateway/protos/notification_v1"
	socialpb "github.com/mkdir-sweden/padpal/gateway/protos/social_v1"
	"github.com/mkdir-sweden/padpal/gateway/social"
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
	"time"
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

	authClient := auth.NewAuthService(authConn)

	key := ""
	for {
		res, err := authClient.GetPublicJwtKey(context.Background(), &authpb.GetPublicJwtKeyRequest{})
		if err != nil {
			log.Printf("Can't get public key, error:%s\n", err)
			time.Sleep(1 * time.Second)
			continue
		}
		key = res.PublicRsaKey
		break
	}

	serverOps = append(serverOps, interceptors.WithJwtValidationUnaryInterceptor(key))
	serverOps = append(serverOps, interceptors.WithJwtValidationStreamInterceptor(key))
	s := grpc.NewServer(serverOps...)

	reflection.Register(s)
	grpc_health_v1.RegisterHealthServer(s, hc.HealthServer)
	socialpb.RegisterSocialService(s, social.NewSocialService(chatConn))
	authpb.RegisterAuthServiceService(s, authClient)
	noticitaionpb.RegisterNotificationService(s, notification.NewNotificationService(notifiConn))
	gamepb.RegisterGameService(s, game.NewGameService(chatConn))
	log.Println("Servning...")
	return s.Serve(lis)
}
