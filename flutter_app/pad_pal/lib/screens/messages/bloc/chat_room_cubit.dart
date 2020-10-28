import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_repository/generated/social_v1/social_service.pb.dart';
import 'package:social_repository/social_repository.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit({
    @required this.socialRepository,
    @required this.chatRoomId,
  })  : assert(socialRepository != null),
        super(ChatRoomState(messages: List.empty())) {
    _startListen();
  }

  final SocialRepository socialRepository;
  final String chatRoomId;

  Future<void> updateLastSeenInRoom() async {
    await socialRepository.updateLastSeen(chatRoomId);
  }

  Future<void> _startListen() async {
    final room = await socialRepository.getChatRoom(chatRoomId);
    emit(state.copyWith(messages: room.messages));

    var stream = await socialRepository.subscribeToRoomEvents(chatRoomId);

    stream.listen((event) {
      switch (event.whichRoomEvent()) {
        case SubscribeToRoomResponse_RoomEvent.newMessage:
          emit(state.copyWith(messages: List<Message>.from([...state.messages, event.newMessage])));
          break;
        case SubscribeToRoomResponse_RoomEvent.notSet:
          throw Exception("RoomEvent not set!");
      }
    });
  }
}
