part of 'chat_room_cubit.dart';

class ChatRoomState extends Equatable {
  const ChatRoomState({@required this.messages});

  final List<Message> messages;

  @override
  List<Object> get props => [messages];

  ChatRoomState copyWith({
    List<Message> messages,
  }) {
    return ChatRoomState(
      messages: messages ?? this.messages,
    );
  }
}
