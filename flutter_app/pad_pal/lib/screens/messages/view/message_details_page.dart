import 'dart:async';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/avatar/avatar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/factories/snack_bar_factory.dart';
import 'package:pad_pal/screens/messages/bloc/chat_room_cubit.dart';
import 'package:pad_pal/screens/messages/view/slide_up_and_down_animation.dart';
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
        child: ChatRoom(),
      ),
    );
  }
}

class ChatRoom extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // void _onFocus() {}

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeInQuad);
    });
  }

  Future<void> _onSend(BuildContext context) async {
    try {
      await context.bloc<ChatRoomCubit>().send(_textController.text);
      _textController.clear();
      _scrollToBottom();
    } catch (e) {
      SnackBarFactory.buildSnackBar("Could not send message", SnackBarType.error);
      rethrow;
    }
  }

  bool _shouldPrintTime(List<MessageModel> messages, int index) {
    if (index == 0) return true;

    final next = messages[index - 1];

    return next.range.getDuration() > Duration(minutes: 30);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<ChatRoomCubit, ChatRoomState>(
                buildWhen: (previous, current) => current.messages.length != previous.messages.length,
                builder: (context, state) {
                  context.bloc<ChatRoomCubit>().updateLastSeenInRoom();

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return BlocBuilder<ChatRoomCubit, ChatRoomState>(
                        // TODO How to only rebuild the widgets that needs to be rebuilt? Eg, newer in time, or has a "seen" status on them
                        builder: (context, state) {
                          final currentIndex = state.messages.length - (index + 1);
                          final currentMessage = state.messages[currentIndex];
                          return Message(
                            model: currentMessage,
                            users: state.users,
                            shouldShowTime: _shouldPrintTime(state.messages, currentIndex) ||
                                state.lastMessagePressed == currentMessage.range.start,
                          );
                        },
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 35,
                  child: FittedBox(
                    child: SlideUpAndDownAnimiation(
                      scrollController: _scrollController,
                      child: FloatingActionButton(
                        onPressed: () => _scrollToBottom(),
                        elevation: 3,
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          color: theme.primaryColor,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ChatTextInput(
            controller: _textController,
            focusNode: _focusNode,
            onChanged: (value) => {},
            onSendTap: () => _onSend(context),
          ),
        )
      ],
    );
  }
}

class AnimateSizeAndFadeWrapper extends StatefulWidget {
  const AnimateSizeAndFadeWrapper({
    Key key,
    @required this.showLast,
    @required this.widget1,
    @required this.widget2,
  }) : super(key: key);

  final bool showLast;
  final Widget widget1;
  final Widget widget2;

  @override
  _AnimateSizeAndFadeWrapperState createState() => _AnimateSizeAndFadeWrapperState();
}

class _AnimateSizeAndFadeWrapperState extends State<AnimateSizeAndFadeWrapper> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //Fade transition does not work, with text, but it does work with color.
    return AnimatedSizeAndFade(
      vsync: this,
      child: widget.showLast
          ? Container(
              key: Key("AnimatedKey1"),
              child: widget.widget1,
            )
          : Container(),
      fadeDuration: Duration(milliseconds: 0),
      sizeDuration: Duration(milliseconds: 250),
    );
  }
}

class Message extends StatelessWidget {
  Message({
    Key key,
    @required this.model,
    @required this.users,
    @required this.shouldShowTime,
  }) : super(key: key);

  final MessageModel model;
  final List<UserModel> users;
  final bool shouldShowTime;

  bool _isWithinTimestamp(UserModel user) {
    return model.range.isWithinRange(user.lastSeen);
  }

  void _onMessageTap(BuildContext context) {
    context.bloc<ChatRoomCubit>().messageTapped(this.model);
  }

  @override
  Widget build(BuildContext context) {
    final myId = context.bloc<MeCubit>().state.me.userId;
    final theme = Theme.of(context);

    final seenStatusUsers = List<UserModel>();
    for (var i = 0; i < users.length; i++) {
      final user = users[i];
      if (user.id == myId || !_isWithinTimestamp(user)) continue;
      seenStatusUsers.add(user);
    }
    final isMe = myId == model.userId;
    final bgColor = isMe ? theme.primaryColor : AppTheme.lightGrayBackground;
    final fontColor = isMe ? Colors.white : Colors.black;
    final axisAlignment = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final textStyle = theme.textTheme.headline3.copyWith(color: fontColor, fontWeight: FontWeight.w400);

    final borderRadius = BorderRadius.circular(18.0);

    final messageAuthor = users.firstWhere((element) => element.id == model.userId);
    final aboveText = isMe ? null : messageAuthor.firstName;

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

    return Column(
      children: [
        Center(child: AnimateSizeAndFadeWrapper(showLast: shouldShowTime, widget1: _Time(model.range.start), widget2: Container())),
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
                  text: model.content,
                  onTap: () => _onMessageTap(context),
                  borderRadius: borderRadius,
                  bgColor: bgColor,
                  textStyle: textStyle,
                ),
              ],
            ),
          ],
        ),
        SeenStatus(
          users: seenStatusUsers,
        ),
      ],
    );
  }
}

class SeenStatus extends StatefulWidget {
  SeenStatus({
    Key key,
    @required this.users,
  }) : super(key: key);

  final List<UserModel> users;

  @override
  _SeenStatusState createState() => _SeenStatusState();
}

class _SeenStatusState extends State<SeenStatus> with SingleTickerProviderStateMixin {
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

  Widget _buildAvatar(UserModel participant) {
    return Avatar(
      name: participant.name,
      borderWidth: 0,
      radius: 8,
      url: participant.imgUrl,
      elevation: 0,
      innerBorderWidth: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset(0, 0),
        ).animate(animation),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [for (var i = 0; i < widget.users.length; i++) _buildAvatar(widget.users[i])],
          ),
          alignment: Alignment.centerRight,
          transform: Matrix4.translationValues(0, -5, 0.0),
        ),
      ),
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

    if (diff.inDays < 6) {
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
