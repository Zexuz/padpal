import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/factories/snack_bar_factory.dart';
import 'package:social_repository/social_repository.dart';

import 'message_form.dart';

class MessageInitRoomPage extends StatelessWidget {
  static Route route(List<Profile> users) {
    return MaterialPageRoute<void>(
      builder: (_) => MessageInitRoomPage(users: users),
    );
  }

  const MessageInitRoomPage({this.users});

  final List<Profile> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "New conversation",
      ),
      body: _MessageInitRoomView(
        users: this.users,
      ),
    );
  }
}

class _MessageInitRoomView extends StatelessWidget {
  _MessageInitRoomView({this.users});

  final TextEditingController _textController = TextEditingController();

  final List<Profile> users;

  Future<void> _onSend(BuildContext context) async {
    try {
      final socialRepo = RepositoryProvider.of<SocialRepository>(context);
      final roomId = await socialRepo.createRoom(users.map((e) => e.userId).toList(), _textController.text);
      Navigator.of(context).pop(roomId);
    } catch (e) {
      SnackBarFactory.buildSnackBar("Could not create conversation", SnackBarType.error);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Sending a message here will create a new conversation with the following people:",
                  textAlign: TextAlign.center,
                ),
                for (var value in users)
                  Text(
                    "${value.name}",
                    style: theme.textTheme.headline3,
                  ),
              ],
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ChatTextInput(
            controller: _textController,
            onSendTap: () => _onSend(context),
          ),
        )
      ],
    );
  }
}
