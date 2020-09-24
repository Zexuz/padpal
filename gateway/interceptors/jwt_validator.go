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
	"log"
	"strings"
	"time"
)

// TODO
// Implement validation of proto files
// https://github.com/envoyproxy/protoc-gen-validate
// https://github.com/grpc-ecosystem/go-grpc-middleware

// TODO
// Validate JWT token here in the gateway

func WithJwtValidationUnaryInterceptor() grpc.DialOption {
	m := &myObject{
		publicKey: []byte("-----BEGIN CERTIFICATE-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9SFtmaHLsT0mnNvDJ+zyXkKR5gJz21FGLOh1DDkIbANWZPWz0I3rR+Ltap6LUixwbUm8XvdUsmc4AxpEceblviw7oAz8t9Ju29/WsvmmRJA2NOdWOL88Ob7ghp4yDEGtGxVaoRlrnzNrdczAGIMpvLXggvrK49mu9llT8RH1Z3V0ZMQ8Akc3D6y+ddADvNEx7Vz2OTP0ISEr+7ZC4appC5dkTzyXePp8drZvsITe0ejMP4ZXo7UNgly7x+vNyzfnAv+6HgFSc72SBJncSjOhXuMJIg1f3PgQ1CHu2Yn+w2ZXNg5D7icSU1dv/6H1UTvg+YEAMi7dqpX8QpZWDxBWbQIDAQAB\n-----END CERTIFICATE-----"),
	}
	return grpc.WithUnaryInterceptor(m.jwtValidator)
}

type myObject struct {
	publicKey []byte
}

func (o *myObject) jwtValidator(
	ctx context.Context,
	method string,
	req interface{},
	reply interface{},
	cc *grpc.ClientConn,
	invoker grpc.UnaryInvoker,
	opts ...grpc.CallOption,
) error {

	start := time.Now()

	option, err := o.getAuthorizationOption(req, method)
	if err != nil {
		return err
	}

	if option.GetShouldValidate() {
		tokenString, err2 := getTokenFromHeader(ctx)
		if err2 != nil {
			return err2
		}

		token, err := jwt.ParseWithClaims(tokenString, &jwt.StandardClaims{}, keyFunc(o.publicKey))
		if err != nil {
			return err
		}

		if !token.Valid {
			return errors.New("token is not valid")
		}

		if standard, ok := token.Claims.(*jwt.StandardClaims); ok {
			md, ok := metadata.FromIncomingContext(ctx)
			if !ok {
				return errors.New("not ok")
			}
			md.Set("padpal-user-id", standard.Subject)
			ctx = metadata.NewIncomingContext(ctx, md)
		} else {
			return errors.New("token claims is wrong")
		}
	}

	elapsed := time.Since(start)
	log.Printf("Binomial took %s", elapsed)

	err = invoker(ctx, method, req, reply, cc, opts...)
	return err
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
		return "", errors.New("not ok")
	}
	authorization := md.Get("authorization")
	if len(authorization) == 0 {
		return "", errors.New("missing authorization header")
	}
	if len(authorization) != 1 {
		return "", errors.New(fmt.Sprintf("authorization header has %d lenght", len(authorization)))
	}

	splits := strings.Split(authorization[0], " ")

	if len(splits) != 2 {
		return "", errors.New(fmt.Sprintf("authorization header more then two splits, actual: %d", len(splits)))
	}

	tokenString := splits[1]
	return tokenString, nil
}

func (o *myObject) getAuthorizationOption(req interface{}, method string) (*rulepb.Authorization, error) {
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
		return nil, errors.New("could not get Authorization option")
	}
	return rule, nil
}
