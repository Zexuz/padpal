import 'package:flutter/material.dart';
import 'package:game_repository/generated/common_v1/models.pb.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/theme.dart';

class ChatTextInput extends StatelessWidget {
  const ChatTextInput({
    Key key,
    this.onSendTap,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.readOnly = false,
  });

  final ValueChanged<String> onChanged;
  final VoidCallback onSendTap;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CustomTextInput(
          onChanged: onChanged,
          focusNode: focusNode,
          controller: controller,
          readOnly: readOnly,
        ),
        Align(
          child: TextButton(
            onPressed: onSendTap,
            child: Text("Send"),
          ),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}

class OverlappingAvatar extends StatelessWidget {
  const OverlappingAvatar({
    Key key,
    @required this.avatar1,
    @required this.avatar2,
  }) : super(key: key);

  final Avatar avatar1;
  final Avatar avatar2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        avatar1,
        Padding(
          padding: EdgeInsets.only(left: avatar1.radius, top: avatar1.radius),
          child: avatar2,
        ),
      ],
    );
  }
}

class MessageListTile extends StatelessWidget {
  const MessageListTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.users,
    @required this.onTap,
    this.unread = false,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final List<User> users;
  final VoidCallback onTap;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.headline4;

    final avatar = users.length == 1
        ? Avatar(
            url: users[0].imgUrl,
            name: users[0].name,
            radius: 24,
            borderWidth: 0,
            elevation: 0,
          )
        : OverlappingAvatar(
            avatar1: Avatar(
              url: users[0].imgUrl,
              name: users[0].name,
              radius: 16,
              borderWidth: 0,
              elevation: 0,
            ),
            avatar2: Avatar(
              url: users[1].imgUrl,
              name: users[1].name,
              radius: 16,
              borderWidth: 2,
              elevation: 0,
              color: Colors.white,
            ),
          );

    return InkWell(
      borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
      onTap: this.onTap,
      child: Container(
        child: Row(
          children: [
            avatar,
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textStyle, overflow: TextOverflow.ellipsis),
                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: this.unread == true ? textStyle : textStyle.copyWith(color: AppTheme.lightGrayText),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            if (unread) Unread(),
          ],
        ),
      ),
    );
  }
}

class Unread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 12,
      height: 12,
      child: Container(),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primaryColor,
      ),
    );
  }
}

class MessageListTileData {
  MessageListTileData({
    this.title,
    this.subtitle,
    this.unread,
    this.users,
    this.roomId,
  }) : assert(users.length > 0);

  final String title;
  final String subtitle;
  final Map<int, bool> unread;
  final List<User> users;
  final String roomId;
}
