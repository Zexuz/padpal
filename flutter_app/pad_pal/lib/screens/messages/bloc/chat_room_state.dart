part of 'chat_room_cubit.dart';

class MessageModel {
  MessageModel({
    @required this.userId,
    @required this.content,
    @required this.range,
  });

  final String content;
  final int userId;
  final TimestampRange range;

  MessageModel copyWith({
    String content,
    int userId,
    TimestampRange range,
  }) {
    return MessageModel(
      userId: userId ?? this.userId,
      content: content ?? this.content,
      range: range ?? this.range,
    );
  }
}

class TimestampRange {
  TimestampRange({
    @required this.start,
    @required this.end,
  });

  final int start;
  final int end;

  bool isWithinRange(int timestamp) {
    if (timestamp >= this.start && timestamp <= this.end) {
      return true;
    }
    return false;
  }

  Duration getDuration(){
    return Duration(milliseconds: end-start);
  }
}

class UserModel {
  UserModel({
    @required this.name,
    @required this.firstName,
    @required this.lastSeen,
    @required this.id,
    @required this.imgUrl,
  });

  final String name;
  final String firstName;
  final int lastSeen;
  final int id;
  final String imgUrl;

  factory UserModel.fromProto(Participant participant) {
    return UserModel(
      name: participant.user.name,
      firstName: participant.user.name.split(" ")[0],
      lastSeen: participant.lastSeenTimestamp.toInt(),
      id: participant.user.userId,
      imgUrl: participant.user.imgUrl,
    );
  }
}

class ChatRoomState extends Equatable {
  const ChatRoomState({
    @required this.messages,
    @required this.users,
    @required this.lastSeenChanged,
  });

  final List<UserModel> users;
  final List<MessageModel> messages;
  final int lastSeenChanged;

  @override
  List<Object> get props => [
        messages,
        users,
        lastSeenChanged,
      ];

  ChatRoomState copyWith({
    List<UserModel> users,
    List<MessageModel> messages,
    int lastSeenChanged,
  }) {
    return ChatRoomState(
      users: users ?? this.users,
      messages: messages ?? this.messages,
      lastSeenChanged: lastSeenChanged ?? this.lastSeenChanged,
    );
  }
}
