package hc

import (
	"github.com/stretchr/testify/assert"
	"google.golang.org/grpc"
	"testing"
)

func TestAddChecker_ErrIfServiceAlreadyAdded(t *testing.T) {
	err := AddChecker("service1", &grpc.ClientConn{})
	assert.NoError(t, err)

	err = AddChecker("service1", &grpc.ClientConn{})
	assert.Error(t, err)
}
