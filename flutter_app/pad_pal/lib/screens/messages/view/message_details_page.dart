import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/avatar/avatar.dart';
import 'package:pad_pal/theme.dart';
import 'package:social_repository/generated/common_v1/models.pb.dart';
import 'package:social_repository/generated/social_v1/social_service.pb.dart';
import 'package:social_repository/social_repository.dart';

import 'message_form.dart';

class MessageDetailsPage extends StatelessWidget {
  static Route route(String title, String roomId) {
    return MaterialPageRoute<void>(
      builder: (_) => MessageDetailsPage(
        title: title,
        roomId: roomId,
      ),
    );
  }

  const MessageDetailsPage({
    Key key,
    @required this.title,
    @required this.roomId,
  }) : super(key: key);

  final String title;
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: title,
      ),
      body: MessageDetails(
        roomId: roomId,
      ),
    );
  }
}

class MessageDetails extends StatefulWidget {
  const MessageDetails({this.roomId});

  final String roomId;

  @override
  _MessageDetailsState createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  var isLoading = true;
  ChatRoom room;
  int myUserId;
  String inputValue = "";

  Future<void> _loadRoom() async {
    final socialRepo = RepositoryProvider.of<SocialRepository>(context);
    final room = await socialRepo.getChatRoom(widget.roomId);
    final me = await socialRepo.getMyProfile();

    setState(() {
      this.room = room;
      myUserId = me.userId;
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRoom();
  }

  User _getAuthorForMessage(Message message) {
    return room.participants.firstWhere((element) => element.userId == message.author);
  }

  Future<void> _onSend() async {
    _textController.clear();
    _focusNode.unfocus();
    final socialRepo = RepositoryProvider.of<SocialRepository>(context);
    await socialRepo.sendMessage(inputValue, room.id);
  }

  void _onInputChanged(String newValue) {
    setState(() {
      inputValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: const Text("Loading..."));
    }

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: room.messages.length,
              itemBuilder: (context, index) {
                final message = room.messages[index];
                final messageAuthor = _getAuthorForMessage(message);
                final leading = message.author == myUserId
                    ? null
                    : Avatar(
                        name: messageAuthor.name,
                        borderWidth: 0,
                        radius: 18,
                        url: messageAuthor.imgUrl,
                        elevation: 0,
                        innerBorderWidth: 0,
                      );

                return Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: ChatMessage(
                    text: message.content,
                    leading: leading,
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ChatTextInput(
            controller: _textController,
            focusNode: _focusNode,
            onChanged: (value) => _onInputChanged(value),
            onSendTap: _onSend,
          ),
        )
      ],
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key key,
    @required this.text,
    this.leading,
  }) : super(key: key);

  final String text;
  final Widget leading;

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.60;
    final isMe = leading == null;

    final bgColor = isMe ? theme.primaryColor : AppTheme.lightGrayBackground;
    final fontColor = isMe ? Colors.white : Colors.black;
    final axisAlignment = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final textStyle = theme.textTheme.headline3.copyWith(color: fontColor, fontWeight: FontWeight.w400);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: axisAlignment,
      children: [
        if (!isMe) leading,
        const SizedBox(width: 12),
        ConstrainedBox(
          constraints: new BoxConstraints(
            maxWidth: width,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.5),
              child: Text(text, style: textStyle),
            ),
          ),
        ),
      ],
    );
  }
}
