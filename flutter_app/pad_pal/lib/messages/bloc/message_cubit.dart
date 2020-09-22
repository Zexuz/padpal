import 'dart:async';

import 'package:chat_repository/src/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/services/notification/notification_service.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.repository) : super(MessageState()..messages = []);

  final ChatRepository repository;
  final _notificationStream = NotificationManager().notification;
  StreamSubscription _streamSub;

  Future<void> sendMessage(String message) async {
    await repository.sendMessage(message);
  }

  Future<void> listenForMessages() async {
    if (_streamSub != null) return;

    _streamSub = _notificationStream.listen((event) {
      if (event.type != Notification.chatMessage) return;
      final chatMessage = event as ChatMessageNotification;
      emit(MessageState()..messages = List.from([...state.messages, chatMessage.content]));
    });
  }

  Future<void> stopListenForMessages() async {
    _streamSub.cancel();
  }
}

class MessageState {
  List<String> messages = [];
}
