import 'dart:async';

import 'package:chat_repository/src/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.repository) : super(MessageState()..messages = []);

  final ChatRepository repository;

  Future<void> sendMessage(String message) async {
    await repository.sendMessage(message);
  }

  Future<void> listenForMessages() async {
    await repository.startListenForMessages();
    repository.streamController.stream.listen((event) {
      print(event);
      print(state.messages.length);
      emit(MessageState()..messages = List.from([...state.messages, event]));
    });
  }

  Future<void> stopListenForMessages() async {
    // await repository.stop(message);
  }
}

class MessageState {
  List<String> messages = [];
}
