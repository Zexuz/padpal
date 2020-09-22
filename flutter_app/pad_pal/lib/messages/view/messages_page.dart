import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/messages/bloc/message_cubit.dart';
import 'package:pad_pal/messages/view/message_form.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => MessageCubit(
            context.repository<ChatRepository>(),
          ),
          child: MessageForm(),
        ),
      ),
    );
  }
}
