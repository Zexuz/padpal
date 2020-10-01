package hc

import (
	"context"
	"errors"
	"fmt"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/status"
	"log"
	"time"
)

var services = map[string]grpc_health_v1.HealthClient{}

const interval = 15 * time.Second

var HealthServer = health.NewServer()

func init() {
	go func() {
		time.Sleep(1 * time.Second)
		for {
			for serviceName, client := range services {
				if HealthServer == nil {
					panic("can't add services before assigning a HealthServer")
				}

				res, err := client.Check(context.Background(), &grpc_health_v1.HealthCheckRequest{
					Service: "",
				})
				if err != nil {
					if stat, ok := status.FromError(err); ok && stat.Code() == codes.Unimplemented {
						log.Printf("the service %s doesn't implement the grpc health protocol\n", serviceName)
					} else {
						log.Printf("rpc failed for service %s, err: %s", serviceName, err)
						HealthServer.SetServingStatus(serviceName, grpc_health_v1.HealthCheckResponse_NOT_SERVING)
					}
				} else {
					HealthServer.SetServingStatus(serviceName, res.Status)
				}
			}
			time.Sleep(interval)
		}
	}()
}

func AddChecker(serviceName string, conn *grpc.ClientConn) error {
	if _, ok := services[serviceName]; ok {
		return errors.New(fmt.Sprintf("serivce %s already exists in map", serviceName))
	}

	services[serviceName] = grpc_health_v1.NewHealthClient(conn)
	HealthServer.SetServingStatus(serviceName, grpc_health_v1.HealthCheckResponse_UNKNOWN)
	return nil
}

func GetAllRegisteredService() map[string]string {
	s := map[string]string{}

	for serviceName, _ := range services {
		res, err := HealthServer.Check(context.Background(), &grpc_health_v1.HealthCheckRequest{
			Service: serviceName,
		})
		if err != nil {
			log.Printf("GetAllRegisteredService, service %s , err: %s\n", serviceName, err)
			s[serviceName] = grpc_health_v1.HealthCheckResponse_UNKNOWN.String()
		} else {
			s[serviceName] = res.Status.String()
		}
	}
	return s
}
