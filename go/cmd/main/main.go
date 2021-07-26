package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/segmentio/kafka-go"
	"google.golang.org/protobuf/proto"
	"test.com/internal/callCount"
)

type CallCountMessage struct {
	TenantId  string
	CallCount []byte
}

func main() {

	message, err := createProtoCallCount("12345", 1)
	if err != nil {
		log.Fatal("failed to create protobuf message:", err)
	}

	topic := "call_counts"
	partition := 0

	conn, err := kafka.DialLeader(context.Background(), "tcp", "localhost:19092", topic, partition)
	if err != nil {
		log.Fatal("failed to dial leader:", err)
	}

	conn.SetWriteDeadline(time.Now().Add(10 * time.Second))
	_, err = conn.WriteMessages(
		kafka.Message{
			Key:   []byte("56789"),
			Value: message,
		},
	)
	if err != nil {
		log.Fatal("failed to write messages:", err)
	}

	if err := conn.Close(); err != nil {
		log.Fatal("failed to close writer:", err)
	}

}

func createProtoCallCount(clientId string, count int32) ([]byte, error) {
	cc := callCount.CallCount{
		ClientId: clientId,
		Count:    count,
	}

	out, err := proto.Marshal(&cc)
	if err != nil {
		return nil, fmt.Errorf("could not marshal protobuf: %s", err)
	}

	return out, nil
}
