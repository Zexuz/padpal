import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_repository/generated/social_v1/social_service.pb.dart';
import 'package:social_repository/social_repository.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit({
    @required this.socialRepository,
    @required this.chatRoomId,
  })  : assert(socialRepository != null),
        super(ChatRoomState(messages: List.empty(), users: List.empty(), lastSeenChanged: 0)) {
    _startListen();
    updateLastSeenInRoom();
  }

  static const int MAX_TIMESTAMP = 1893456000000; //2030 01 01 00:00 in milliseconds

  final SocialRepository socialRepository;
  final String chatRoomId;

  Future<void> send(String message) async {
    await socialRepository.sendMessage(message, chatRoomId);
  }

  Future<void> updateLastSeenInRoom() async {
    await socialRepository.updateLastSeen(chatRoomId);
  }

  Future<void> _startListen() async {
    final room = await socialRepository.getChatRoom(chatRoomId);
    final messages = _getAndParseMessages(room); // TODO use compute here to optimize perfomace?
    final users = _getAndParseUsers(room);
    emit(state.copyWith(messages: messages, users: users));

    var stream = await socialRepository.subscribeToRoomEvents(chatRoomId);

    stream.listen((event) {
      print("received event of type ${event.whichRoomEvent()}");
      switch (event.whichRoomEvent()) {
        case SubscribeToRoomResponse_RoomEvent.notSet:
          throw Exception("RoomEvent not set!");
        case SubscribeToRoomResponse_RoomEvent.newMessage:
          final ev = event.newMessage;
          final lastMessageTemp = state.messages.removeLast();
          final lastMessage = lastMessageTemp.copyWith(
            range: TimestampRange(
              start: lastMessageTemp.range.start,
              end: ev.utcTimestamp.toInt(),
            ),
          );

          emit(state.copyWith(messages: <MessageModel>[
            ...state.messages,
            lastMessage,
            MessageModel(
              userId: ev.author,
              content: ev.content,
              range: TimestampRange(start: ev.utcTimestamp.toInt(), end: MAX_TIMESTAMP),
            ),
          ]));
          break;
        case SubscribeToRoomResponse_RoomEvent.lastSeenUpdated:
          final ev = event.lastSeenUpdated;
          final users = List<UserModel>();

          for (var i = 0; i < room.participants.length; i++) {
            final participant = room.participants[i];

            if (ev.userId == participant.user.userId) {
              participant..lastSeenTimestamp = ev.timestamp;
            }
            users.add(UserModel.fromProto(participant));
          }
          emit(state.copyWith(users: users, lastSeenChanged: ev.timestamp.toInt()));
          break;
      }
    });
  }

  List<MessageModel> _getAndParseMessages(ChatRoom room) {
    final List<MessageModel> messages = List();
    for (var i = 0; i < room.messages.length; i++) {
      final currentMessage = room.messages[i];
      final isLastMessage = room.messages.length - i == 1;
      final nextMessage = isLastMessage ? currentMessage : room.messages[i + 1];

      TimestampRange range;
      if (isLastMessage) {
        range = TimestampRange(start: currentMessage.utcTimestamp.toInt(), end: MAX_TIMESTAMP);
      } else {
        range = TimestampRange(start: currentMessage.utcTimestamp.toInt(), end: nextMessage.utcTimestamp.toInt());
      }
      messages.add(MessageModel(userId: currentMessage.author, content: currentMessage.content, range: range));
    }

    return messages;
  }

  List<UserModel> _getAndParseUsers(ChatRoom room) {
    return room.participants.map((e) => UserModel.fromProto(e)).toList();
  }
}
