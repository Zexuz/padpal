package main

import (
	"context"
	"fmt"
	"github.com/golang-migrate/migrate"
	"google.golang.org/grpc"
	"log"
	"login/internal/sql"
	"net"

	_ "github.com/golang-migrate/migrate/source/file"
	pb "login/pkg/service/user"
)

const (
	port = 50051
)

func main() {
	db, _ := sql.Open("padel_360")
	err := sql.MigrateUp(db)

	if err == migrate.ErrNoChange {
		print("No migration needed, everything is up to date")
	} else if err != nil {
		panic(err)
	}

	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	grpcServer := grpc.NewServer()
	pb.RegisterUserServer(grpcServer, &userServer{})
	grpcServer.Serve(lis)
}

type userServer struct {
	pb.UnimplementedUserServer
}

func (u *userServer) Register(ctx context.Context, request *pb.RegisterRequest) (*pb.RegisterResponse, error) {
	fmt.Printf("\nUsername %s, first name %s, last name %s, email %s,", request.Username, request.FirstName, request.LastName, request.Email)
	return &pb.RegisterResponse{}, nil
}
