package main

import (
	"context"
	"firebase.google.com/go/v4"
	"firebase.google.com/go/v4/messaging"
	"fmt"
	"log"
	"time"
)

func main() {
	app, err := firebase.NewApp(context.Background(), nil)
	if err != nil {
		log.Fatalf("error initializing app: %v\n", err)
	}

	// Obtain a messaging.Client from the App.
	ctx := context.Background()
	client, err := app.Messaging(ctx)
	if err != nil {
		log.Fatalf("error getting Messaging client: %v\n", err)
	}

	// This registration token comes from the client FCM SDKs.
	registrationTokens := []string{
		"c0pG3e7GSGGh18S9TIcedy:APA91bELLl_ZkM7JricKxMGu0MqbxS4vJS2kEW_fRTvknmX7cFxrrGSpOvbIPHgmicOhXeM3IZ5wxh5E_2wh0yOtIa3ZAuYxnfl3A7mxRtFLH5wTfScUNP7rjBC55Gw5D6fqgJlYiFxA",
		"cWUCUPepTwWIxXH3jLShCR:APA91bHtjgkh5_qnBkKCwQIaI9MjEE1vweLeBBvFwRS7B5UMmH41J9mmTIHtMMOvT9FYAYvs5bJDrUAqAYRB5JWcl6frFusyLPHwIWJtkqqizc9PggFOJdkEjf_x2obaZ4NWtxOmhuez",
	}

	// See documentation on defining a message payload.
	message := &messaging.MulticastMessage{
		Data: map[string]string{
			"title": "from golang",
			"body":  "some text body",
		},
		Tokens: registrationTokens,
	}

	ticker := time.NewTicker(5 * time.Second)
	quit := make(chan struct{})

	select {
	case <-ticker.C:
		// do stuff
	case <-quit:
		ticker.Stop()
	}

	// Send a message to the device corresponding to the provided
	// registration token.
	response, err := client.SendMulticast(ctx, message)
	if err != nil {
		log.Fatalln(err)
	}
	// Response is a message ID string.
	fmt.Println("Successfully sent message:", response)
}
