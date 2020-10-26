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
    Stream.periodic(Duration(seconds: 1), (_) => socialRepository.getChatRoom(chatRoomId))
        .asyncMap((event) async => await event)
        .listen((event) {
      emit(state.copyWith(messages: event.messages));
    });
  }

  final SocialRepository socialRepository;
  final String chatRoomId;

  Future<void> updateLastSeenInRoom() {
    // TODO
    // Send a request to the server, telling it that I was last seen now
  }
//
// Future<void> getMessagesForChatRoom() async {
// }

}
