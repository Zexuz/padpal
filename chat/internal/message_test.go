package internal

import (
	"github.com/pkg/errors"
	"github.com/stretchr/testify/assert"
	"testing"
	"time"
)

func TestCreateChatRoom_should_return_chatRoom(t *testing.T) {
	a := assert.New(t)

	admin := 1337
	participants := []int{25}

	got, err := CreateChatRoom(admin, participants)
	if err != nil {
		t.Errorf("CreateChatRoom() error = %v, expecetd no error", err)
		return
	}

	a.Equal(1337, got.Admin)

	a.Equal(1337, got.Participants[0].Id)
	a.WithinDuration(time.Now().UTC(), got.Participants[0].LastSeenInChat, 10*time.Second)

	a.Equal(25, got.Participants[1].Id)
	a.WithinDuration(time.Now().UTC(), got.Participants[1].LastSeenInChat, 10*time.Second)
}

func TestCreateChatRoom_should_return_error_if_no_participants_is_provided(t *testing.T) {
	a := assert.New(t)

	admin := 1337
	var participants []UserId

	_, err := CreateChatRoom(admin, participants)

	a.True(errors.Is(err, ErrInvalidParameters), "CreateChatRoom() error = %v, expected %v", err, ErrInvalidParameters)
}

func TestAddMessageToChatRoom(t *testing.T) {
	a := assert.New(t)

	room := ChatRoom{
		Id:           "",
		Admin:        0,
		Participants: createParticipants(1337),
		Messages:     []Message{},
	}

	err := AddMessageToChatRoom(1337, "someContent", &room)
	if err != nil {
		t.Errorf("AddMessageToChatRoom() error = %v, expecetd no error", err)
		return
	}

	a.Len(room.Messages, 1)
	a.WithinDuration(time.Now().UTC(), room.Messages[0].Timestamp, 10*time.Second)
}

func TestAddMessageToChatRoom_should_raise_error(t *testing.T) {
	type args struct {
		author  UserId
		content string
		room    *ChatRoom
	}
	tests := []struct {
		name        string
		args        args
		expectedErr error
	}{
		{
			name: "When userId is 0",
			args: args{
				author:  0,
				content: "",
				room:    &ChatRoom{},
			},
			expectedErr: ErrInvalidParameters,
		},
		{
			name: "When userId is -10",
			args: args{
				author:  -10,
				content: "",
				room:    &ChatRoom{},
			},
			expectedErr: ErrInvalidParameters,
		},
		{
			name: "When userId is nil",
			args: args{
				author:  -10,
				content: "",
				room:    &ChatRoom{},
			},
			expectedErr: ErrInvalidParameters,
		},
		{
			name: "When author is not a participant",
			args: args{
				author:  1337,
				content: "some content",
				room: &ChatRoom{
					Id:           "",
					Admin:        0,
					Participants: createParticipants(25),
					Messages:     []Message{},
				},
			},
			expectedErr: ErrAuthorNotParticipant,
		},
		{
			name: "When participant is nil",
			args: args{
				author:  1337,
				content: "some content",
				room: &ChatRoom{
					Id:           "",
					Admin:        0,
					Participants: nil,
					Messages:     []Message{},
				},
			},
			expectedErr: ErrAuthorNotParticipant,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			a := assert.New(t)

			err := AddMessageToChatRoom(tt.args.author, tt.args.content, tt.args.room)

			if tt.expectedErr != nil {
				a.True(errors.Is(err, tt.expectedErr), "AddMessageToChatRoom() error = %v, expected %v", err, tt.expectedErr)
			} else {
				a.Nil(err)
			}
		})
	}
}

func createParticipants(ids ...UserId) []Participant {
	par := make([]Participant, 0, len(ids))

	for _, userId := range ids {
		par = append(par, Participant{
			Id:             userId,
			LastSeenInChat: time.Now().UTC(),
		})
	}

	return par
}
