package main

import (
	"flag"
	"github.com/mkdir-sweden/padpal/gateway/auth"
	"github.com/mkdir-sweden/padpal/gateway/authpb"
	"github.com/mkdir-sweden/padpal/gateway/chat"
	"github.com/mkdir-sweden/padpal/gateway/chatpb"
	"google.golang.org/grpc"
	"log"
	"net"
)

const (
	port = ":50051"
)

// TODO
// Implement validation of proto files
// https://github.com/envoyproxy/protoc-gen-validate
// https://github.com/grpc-ecosystem/go-grpc-middleware

// TODO
// Validate JWT token here in the gateway

func main() {

	flag.Parse()
	var opts []grpc.DialOption
	opts = append(opts, grpc.WithInsecure())

	opts = append(opts, grpc.WithBlock())
	chatConn, err := grpc.Dial("localhost:5001", opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}

	authConn, err := grpc.Dial("localhost:5002", opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer chatConn.Close()
	defer authConn.Close()

	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()

	chatpb.RegisterChatServiceService(s, chat.NewChatService(chatConn))
	authpb.RegisterAuthServiceService(s, auth.NewAuthService(authConn))
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
