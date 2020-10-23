import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatTextInput extends StatelessWidget {
  const ChatTextInput({
    Key key,
    this.onSendTap,
    this.onChanged,
  });

  final ValueChanged<String> onChanged;
  final VoidCallback onSendTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CustomTextInput(
          onChanged: onChanged,
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

class ProfilePictureData {
  const ProfilePictureData({
    this.img,
    this.name,
  }) : assert(img == null || name == null);

  final String name;
  final String img;
}

class MessageListTile extends StatelessWidget {
  const MessageListTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.user,
    this.secondUser = null,
    this.unread = false,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool unread;
  final ProfilePictureData user;
  final ProfilePictureData secondUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.headline4;

    final avatar = secondUser == null
        ? Avatar(
            url: user.img,
            radius: 24,
            borderWidth: 0,
            elevation: 0,
          )
        : OverlappingAvatar(
            avatar1: Avatar(
              url: user.img,
              radius: 16,
              borderWidth: 0,
              elevation: 0,
            ),
            avatar2: Avatar(
              url: secondUser.img,
              radius: 16,
              borderWidth: 2,
              elevation: 0,
              color: Colors.white,
            ),
          );

    return InkWell(
      borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
      onTap: () => {},
      child: Container(
        child: Row(
          children: [
            avatar,
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textStyle),
                  Text(subtitle,
                      style: this.unread == true ? textStyle : textStyle.copyWith(color: AppTheme.lightGrayText)),
                ],
              ),
            ),
            Expanded(child: Container()),
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
    this.images,
  })  : assert(images.length > 0),
        assert(images.length < 3);

  final String title;
  final String subtitle;
  final bool unread;
  final List<String> images;
}

class MessageForm extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  Future<void> _onRefresh(BuildContext context) async {
    // final filter = context.bloc<EventFilterCubit>().state;
    // if (filter == null) {
    //   _refreshController.refreshFailed();
    //   return;
    // }
    // await context.bloc<EventCubit>().findGames(filter);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final items = <MessageListTileData>[
      MessageListTileData(title: "Wim Willems", subtitle: "Btw this is a really cool app", unread: true, images: [
        "https://randomuser.me/api/portraits/men/21.jpg",
      ]),
      MessageListTileData(title: "Andries Grootoonk", subtitle: "Hahaha that’s great!!", unread: false, images: [
        "https://randomuser.me/api/portraits/men/74.jpg",
      ]),
      MessageListTileData(
          title: "David, Robin, Oliver and Edu",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
      MessageListTileData(
          title: "Wed 23 Sep.12.00-13.00 pm",
          subtitle: "See you on Thursday guys!",
          unread: false,
          images: [
            "https://randomuser.me/api/portraits/women/21.jpg",
            "https://randomuser.me/api/portraits/women/20.jpg",
          ]),
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ChatTextInput(
              onChanged: (value) => print(value),
              onSendTap: () {},
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              header: MaterialClassicHeader(),
              controller: _refreshController,
              onRefresh: () async {
                await _onRefresh(context);
              },
              child: ListView.builder(
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: MessageListTile(
                      title: items[i].title,
                      subtitle: items[i].subtitle,
                      unread: items[i].unread,
                      user: ProfilePictureData(img: items[i].images[0]),
                      secondUser: items[i].images.length == 2 ? ProfilePictureData(img: items[i].images[1]) : null,
                    ),
                  );
                },
                itemCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
