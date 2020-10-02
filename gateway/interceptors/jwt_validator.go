package interceptors

import (
	"context"
	"errors"
	"fmt"
	"github.com/ahmetb/go-linq"
	"github.com/dgrijalva/jwt-go"
	"github.com/golang/protobuf/descriptor"
	rulepb "github.com/mkdir-sweden/padpal/gateway/protos/descriptors"
	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/types/descriptorpb"
	"strings"
)

// TODO
// Implement validation of proto files
// https://github.com/envoyproxy/protoc-gen-validate
// https://github.com/grpc-ecosystem/go-grpc-middleware

var (
	ErrMissingAuthorizationOption        = errors.New("could not get Authorization option")
	ErrCouldNotParseIncomingMetadata     = errors.New("could not parse incoming metadata")
	ErrMissingAuthorizationHeader        = errors.New("missing authorization header")
	ErrToManyValuesInAuthorizationHeader = errors.New("header has more than one item")
	ErrMalformedAuthorizationHeader      = errors.New("header does not have format 'Bearer <token>'")
	ErrTokenInvalid                      = errors.New("token is invalid")
	ErrInvalidClaims                     = errors.New("claims are wrong")
)

func WithJwtValidationUnaryInterceptor(base64Key string) grpc.ServerOption {
	key := fmt.Sprintf("-----BEGIN CERTIFICATE-----\n%s\n-----END CERTIFICATE-----", base64Key)
	m := &myObject{
		publicKey: []byte(key),
	}
	return grpc.UnaryInterceptor(m.jwtValidator)
}

type myObject struct {
	publicKey []byte
}

func (o *myObject) jwtValidator(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (resp interface{}, err error) {
	option, err := o.getAuthorizationOption(req, info.FullMethod)
	if err != nil {
		return nil, err
	}

	if option.GetShouldValidate() {
		tokenString, err2 := getTokenFromHeader(ctx)
		if err2 != nil {
			return nil, err2
		}

		token, err := jwt.ParseWithClaims(tokenString, &jwt.StandardClaims{}, keyFunc(o.publicKey))
		if err != nil {
			return nil, err
		}

		if !token.Valid {
			return nil, ErrTokenInvalid
		}

		if standard, ok := token.Claims.(*jwt.StandardClaims); ok {
			md, ok := metadata.FromIncomingContext(ctx)
			if !ok {
				return nil, ErrCouldNotParseIncomingMetadata
			}
			md.Set("padpal-user-id", standard.Subject)
			ctx = metadata.NewOutgoingContext(ctx, md)
		} else {
			return nil, ErrInvalidClaims
		}
	}

	return handler(ctx, req)
}

func keyFunc(pubKey []byte) func(token *jwt.Token) (interface{}, error) {
	return func(token *jwt.Token) (interface{}, error) {
		key, err := jwt.ParseRSAPublicKeyFromPEM(pubKey)
		if err != nil {
			return nil, err
		}

		if _, ok := token.Method.(*jwt.SigningMethodRSA); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}

		return key, nil
	}
}

func getTokenFromHeader(ctx context.Context) (string, error) {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return "", ErrCouldNotParseIncomingMetadata
	}
	authorization := md.Get("authorization")
	if len(authorization) == 0 {
		return "", ErrMissingAuthorizationHeader
	}
	if len(authorization) != 1 {
		print(fmt.Sprintf("authorization header has %d lenght", len(authorization)))
		return "", ErrToManyValuesInAuthorizationHeader
	}

	splits := strings.Split(authorization[0], " ")

	if len(splits) != 2 {
		print(fmt.Sprintf("authorization header more then two splits, actual: %d", len(splits)))
		return "", ErrMalformedAuthorizationHeader
	}

	tokenString := splits[1]
	return tokenString, nil
}

func (o *myObject) getAuthorizationOption(req interface{}, method string) (res *rulepb.Authorization, err error) {
	defer func() {
		if r := recover(); r != nil {
			print(fmt.Sprintf("could not get auth option form request-type: %v", req))
			err = ErrMissingAuthorizationOption
		}
	}()
	fileDescriptor, _ := descriptor.MessageDescriptorProto(req)
	q := linq.From(fileDescriptor.GetService()).Where(func(c interface{}) bool {
		sd := c.(*descriptorpb.ServiceDescriptorProto)
		return strings.HasPrefix(method, fmt.Sprintf("/%s.%s", fileDescriptor.GetPackage(), sd.GetName()))
	}).SelectMany(func(c interface{}) linq.Query {
		sd := c.(*descriptorpb.ServiceDescriptorProto)
		return linq.From(sd.GetMethod())
	}).SingleWith(func(c interface{}) bool {
		md := c.(*descriptorpb.MethodDescriptorProto)
		a := strings.Split(method, "/")[2]
		b := md.GetName()
		return strings.EqualFold(b, a)
	})

	md := q.(*descriptorpb.MethodDescriptorProto)
	ex := proto.GetExtension(md.Options, rulepb.E_Authorization)
	rule, ok := ex.(*rulepb.Authorization)
	if !ok {
		return nil, ErrMissingAuthorizationOption
	}
	return rule, nil
}
