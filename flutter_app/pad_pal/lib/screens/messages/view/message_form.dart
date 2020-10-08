import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/button/light/button_small_light.dart';
import 'package:pad_pal/components/components.dart';

import '../bloc/message_cubit.dart';

class MessageForm extends StatelessWidget {
  final _controller = ScrollController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      buildWhen: (previous, current) => previous.messages.length != current.messages.length,
      builder: (context, state) {
        Timer(
          Duration(seconds: 1),
          () => _controller.jumpTo(_controller.position.maxScrollExtent),
        );

        var messageCubit = context.bloc<MessageCubit>();

        messageCubit.listenForMessages();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 2,
              child: ListView.builder(
                controller: _controller,
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return Text('${state.messages[index]}');
                },
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(border: InputBorder.none, hintText: 'Enter a message'),
                  ),
                ),
                ButtonSmallLight(
                  stretch: false,
                  isDisabled: false,
                  onPressed: () {
                    messageCubit.sendMessage(_textController.value.text);
                    _textController.clear();
                  },
                  text: "send",
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
