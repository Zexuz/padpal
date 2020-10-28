import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/avatar/avatar.dart';
import 'package:pad_pal/screens/messages/bloc/chat_room_cubit.dart';
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
      body: BlocProvider<ChatRoomCubit>(
        create: (context) => ChatRoomCubit(
          socialRepository: RepositoryProvider.of<SocialRepository>(context),
          chatRoomId: roomId,
        ),
        child: MessageDetails(
          roomId: roomId,
        ),
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

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        return;
      }
      _scrollToBottom();
    });
  }

  Future<void> _onSend() async {
    _textController.clear();
    _focusNode.unfocus();
    _scrollToBottom();
    final socialRepo = RepositoryProvider.of<SocialRepository>(context);
    await socialRepo.sendMessage(inputValue, room.id);
  }

  void _onInputChanged(String newValue) {
    setState(() {
      inputValue = newValue;
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await new Future.delayed(const Duration(milliseconds: 250), () => "1");
      final bottom = MediaQuery.of(context).viewInsets.bottom;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent + bottom,
          duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
      print(bottom);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: const Text("Loading..."));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocBuilder<ChatRoomCubit, ChatRoomState>(
                buildWhen: (previous, current) => previous.messages.length != current.messages.length,
                builder: (context, state) {
                  _scrollToBottom();
                  context.bloc<ChatRoomCubit>().updateLastSeenInRoom();

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Column(
                          children: [
                            ChatMessage(
                              messages: state.messages,
                              index: index,
                              users: room.participants,
                              myUserId: myUserId,
                            ),
                          ],
                        ),
                      );
                    },
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
      ),
    );
  }
}

class LastSeen extends StatelessWidget {
  const LastSeen({
    Key key,
    @required Message message,
    @required Message nextMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LastSeenOld extends StatefulWidget {
  LastSeenOld({
    Key key,
    @required this.users,
    @required this.messages,
    @required this.index,
    @required this.myUserId,
  }) : super(key: key);

  final List<Participant> users;
  final List<Message> messages;
  final int index;
  final myUserId;

  @override
  _LastSeenOldState createState() => _LastSeenOldState();
}

class _LastSeenOldState extends State<LastSeenOld> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildAvatar(Participant participant) {
    return Avatar(
      name: participant.user.name,
      borderWidth: 0,
      radius: 8,
      url: participant.user.imgUrl,
      elevation: 0,
      innerBorderWidth: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.index;
    final isLastMessage = currentIndex == widget.messages.length - 1;
    final currentMessage = widget.messages[widget.index];

    final messageTime = currentMessage.utcTimestamp;
    final nextMessageTime = isLastMessage ? 9223372036854775 : widget.messages[currentIndex + 1].utcTimestamp;

    final avatars = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [],
    );
    for (var i = 0; i < widget.users.length; i++) {
      final user = widget.users[i];
      if (user.user.userId == widget.myUserId) continue;

      if (user.lastSeenTimestamp >= messageTime && user.lastSeenTimestamp <= nextMessageTime) {
        avatars.children.add(_buildAvatar(user));
      }
    }

    return Container(
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset(0, 0),
        ).animate(animation),
        child: Container(
          child: avatars,
          alignment: Alignment.centerRight,
          transform: Matrix4.translationValues(0, -5, 0.0),
        ),
      ),
    );
  }
}

class ChatMessage extends StatefulWidget {
  const ChatMessage({
    Key key,
    @required this.users,
    @required this.messages,
    @required this.index,
    @required this.myUserId,
  }) : super(key: key);

  final List<Participant> users;
  final List<Message> messages;
  final int index;
  final myUserId;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  bool showTime = false;

  User _getAuthorForMessage(Message message) {
    return widget.users.firstWhere((element) => element.user.userId == message.author).user;
  }

  bool _shouldPrintTime(List<Message> messages, int index) {
    if (index == 0) return true;
    if (index == messages.length - 1) return true;

    final current = messages[index];
    final prev = messages[index + 1];

    final diff = prev.utcTimestamp - current.utcTimestamp;

    return diff > 60 * 30;
  }

  _onMessageTap() {
    setState(() {
      showTime = true;
    });
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentMessage = widget.messages[widget.index];
    final isMe = currentMessage.author == widget.myUserId;

    final bgColor = isMe ? theme.primaryColor : AppTheme.lightGrayBackground;
    final fontColor = isMe ? Colors.white : Colors.black;
    final axisAlignment = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final textStyle = theme.textTheme.headline3.copyWith(color: fontColor, fontWeight: FontWeight.w400);

    final borderRadius = BorderRadius.circular(18.0);

    final messageAuthor = _getAuthorForMessage(currentMessage);
    final leading = isMe
        ? null
        : Avatar(
            name: messageAuthor.name,
            borderWidth: 0,
            radius: 18,
            url: messageAuthor.imgUrl,
            elevation: 0,
            innerBorderWidth: 0,
          );

    final aboveText = isMe ? null : messageAuthor.name.split(" ").first;

    return Column(
      children: [
        if (showTime || _shouldPrintTime(widget.messages, widget.index))
          _Time(currentMessage.utcTimestamp.toInt() * 1000),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: axisAlignment,
          children: [
            if (!isMe) leading,
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (aboveText != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      aboveText,
                      style: TextStyle(color: AppTheme.lightGrayText, fontSize: 8),
                    ),
                  ),
                ChatMessageContent(
                  text: currentMessage.content,
                  onTap: _onMessageTap,
                  borderRadius: borderRadius,
                  bgColor: bgColor,
                  textStyle: textStyle,
                ),
              ],
            ),
          ],
        ),
        BlocBuilder<ChatRoomCubit, ChatRoomState>(
          builder: (context, state) {
            return LastSeenOld(
              messages: state.messages,
              index: widget.index,
              users: state.participants,
              myUserId: widget.myUserId,
            );
          },
        ),
      ],
    );
  }
}

class _Time extends StatelessWidget {
  _Time(this.timestamp);

  final int timestamp;

  @override
  Widget build(BuildContext context) {
    final messageTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final currentTime = DateTime.now();

    final diff = currentTime.difference(messageTimestamp);

    final dateFormat = _getFormat(diff);
    DateFormat.Hm();
    return Text(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(timestamp)));
  }

  DateFormat _getFormat(Duration diff) {
    if (diff.inDays < 1) {
      return DateFormat.Hm();
    }

    if (diff.inDays < 7) {
      return DateFormat('E @ kk:mm');
    }

    if (diff.inDays < 365) {
      return DateFormat('MMM dd @ kk:mm');
    }

    return DateFormat('y MMM dd @ kk:mm');
  }
}

class ChatMessageContent extends StatelessWidget {
  const ChatMessageContent({
    Key key,
    @required this.text,
    @required this.borderRadius,
    @required this.bgColor,
    @required this.textStyle,
    this.onTap,
  }) : super(key: key);

  final String text;
  final BorderRadius borderRadius;
  final Color bgColor;
  final TextStyle textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.60;

    return ConstrainedBox(
      constraints: new BoxConstraints(
        maxWidth: width,
      ),
      child: Material(
        borderRadius: borderRadius,
        color: bgColor,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(7.5),
            child: Text(text, style: textStyle),
          ),
        ),
      ),
    );
  }
}
