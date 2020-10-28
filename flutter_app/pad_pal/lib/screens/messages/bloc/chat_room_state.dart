part of 'chat_room_cubit.dart';

class ChatRoomState extends Equatable {
  const ChatRoomState({
    @required this.messages,
    @required this.participants,
  });

  final List<Message> messages;
  final List<Participant> participants;

  @override
  List<Object> get props => [messages, participants];

  ChatRoomState copyWith({
    List<Message> messages,
    List<Participant> participants,
  }) {
    return ChatRoomState(
      messages: messages ?? this.messages,
      participants: participants ?? this.participants,
    );
  }
}
