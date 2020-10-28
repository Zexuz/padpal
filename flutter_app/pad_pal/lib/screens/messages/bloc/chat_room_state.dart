part of 'chat_room_cubit.dart';

class ChatRoomState extends Equatable {
  const ChatRoomState({
    @required this.messages,
    @required this.participants,
    @required this.stringMessages,
  });

  final List<Message> messages;
  final List<Participant> participants;
  final List<String> stringMessages;

  @override
  List<Object> get props => [messages, participants,stringMessages];

  ChatRoomState copyWith({
    List<Message> messages,
    List<Participant> participants,
    List<String> stringMessages,
  }) {
    return ChatRoomState(
      messages: messages ?? this.messages,
      participants: participants ?? this.participants,
      stringMessages: stringMessages ?? this.stringMessages,
    );
  }
}
