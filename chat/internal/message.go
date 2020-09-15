package internal

import (
	"fmt"
	"github.com/pkg/errors"
	"time"
)

var (
	ErrInvalidParameters    = errors.New("invalid parameters")
	ErrAuthorNotParticipant = errors.New("author is not a participant")
)

type UserId = int

type Message struct {
	Author    UserId
	Timestamp time.Time
	Content   string
}

type RoomId = string

type Participant struct {
	Id             UserId
	LastSeenInChat time.Time
}

type ChatRoom struct {
	Id           RoomId
	Admin        UserId
	Participants []Participant
	Messages     []Message
}

func AddMessageToChatRoom(author UserId, content string, room *ChatRoom) error {
	if author <= 0 {
		return errors.Wrap(ErrInvalidParameters, fmt.Sprintf("author id %d is not valid ( 0 <= )", author))
	}

	if !participantInSlice(author, room.Participants) {
		return ErrAuthorNotParticipant
	}

	message := Message{
		Author:    author,
		Timestamp: time.Now().UTC(),
		Content:   content,
	}
	room.Messages = append(room.Messages, message)

	return nil
}

func participantInSlice(a UserId, list []Participant) bool {
	for _, b := range list {
		if b.Id == a {
			return true
		}
	}
	return false
}

func CreateChatRoom(admin UserId, participants []UserId) (ChatRoom, error) {
	if len(participants) == 0 {
		return ChatRoom{}, errors.Wrap(ErrInvalidParameters, "participants needs to be > 0")
	}

	par := make([]Participant, 0, len(participants)+1)

	for _, userId := range participants {
		par = append(par, Participant{
			Id:             userId,
			LastSeenInChat: time.Now().UTC(),
		})
	}

	return ChatRoom{
		Id:    "",
		Admin: admin,
		Participants: append([]Participant{{
			Id:             admin,
			LastSeenInChat: time.Now().UTC(),
		}}, par...),
		Messages: []Message{},
	}, nil
}
