import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';

class CreateEventPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateEventPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create event"),
      body: CreateEventView(),
    );
  }
}

class CreateEventView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
    const padding = 3.0;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Players"),
          Text("Lorem ipsom dolar sit amet"),
          Container(
            child: _RawSpotSave(
              url: url,
              name: "Anton Brownstein",
              label: "Beginner",
              addDivider: true,
            ),
            transform: Matrix4.translationValues(-5.0, 0, 0.0),
          ),
          _FriendSpot(
            url: url,
            name: "Andries Grootoonk",
            label: "Beginner",
            addDivider: true,
            onRemoveFriend: () => {},
          ),
          _FreeSpot(
            name: "Player 3",
            addDivider: true,
            onAddFriendPressed: () => {},
          ),
          _FreeSpot(
            name: "Player 4",
            addDivider: true,
            onAddFriendPressed: () => {},
          ),
        ],
      ),
    );
  }
}

enum AvatarType { Me, Friend, Placeholder }

class AvatarBuilder extends StatelessWidget {
  const AvatarBuilder({
    @required this.type,
    this.url,
  }) : assert(type == AvatarType.Placeholder || url != null);

  final AvatarType type;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const radius = 24.0;

    switch (type) {
      case AvatarType.Me:
        return Avatar(
          url: url,
          radius: radius,
          borderWidth: 3.0,
          color: theme.primaryColor,
          elevation: 0,
          innerBorderWidth: 2.0,
        );
      case AvatarType.Friend:
        return Avatar(
          url: url,
          radius: radius,
          borderWidth: 0,
          color: Colors.transparent,
          elevation: 0,
          innerBorderWidth: 0,
        );
      case AvatarType.Placeholder:
        return DottedAvatar(radius: radius);
    }
    throw Exception("No matching types");
  }
}

class _RawSpot extends StatelessWidget {
  const _RawSpot({
    Key key,
    this.action,
    this.avatar,
    @required this.name,
    @required this.label,
    this.addDivider = false,
  }) : super(key: key);

  final String name;
  final String label;
  final bool addDivider;
  final Widget action;
  final Widget avatar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rightPadding = 16.0;
    const radius = 24.0;

    final borderWidth = (action != null) ? 0.0 : 3.0;
    final innerBorderWidth = (action != null) ? 0.0 : 2.0;
    final offset = borderWidth + innerBorderWidth;
    const orPadding = 16.0;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: action == null ? rightPadding - offset : rightPadding),
              child: avatar,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(label),
                ],
              ),
            ),
            if (action != null)
              Padding(
                padding: const EdgeInsets.only(left: orPadding, right: orPadding),
                child: const Text("or"),
              ),
            if (action != null) action,
          ],
        ),
        if (addDivider)
          Divider(
            thickness: 2,
            indent: (radius * 2) + offset + rightPadding,
          ),
      ],
    );
  }
}

class _FreeSpot extends StatelessWidget {
  const _FreeSpot({
    Key key,
    @required this.name,
    @required VoidCallback onAddFriendPressed,
    this.addDivider = false,
  }) : super(key: key);

  final String name;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    return _RawSpot(
      avatar: AvatarBuilder(
        type: AvatarType.Placeholder,
      ),
      name: name,
      label: "Free spot",
      addDivider: addDivider,
      action: ButtonSmallPrimary(
        stretch: false,
        onPressed: () => {},
        text: "Add friend",
        isDisabled: false,
      ),
    );
  }
}

class _FriendSpot extends StatelessWidget {
  const _FriendSpot({
    Key key,
    @required this.name,
    @required this.label,
    @required this.url,
    @required VoidCallback onRemoveFriend,
    this.addDivider = false,
  }) : super(key: key);

  final bool addDivider;
  final String name;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return _RawSpot(
      avatar: AvatarBuilder(
        type: AvatarType.Friend,
        url: url,
      ),
      name: "Kalle",
      label: "Beginner",
      addDivider: addDivider,
      action: ButtonSmallSecondary(
        stretch: false,
        onPressed: () => {},
        text: "Remove",
        isDisabled: false,
      ),
    );
  }
}

class _RawSpotSave extends StatelessWidget {
  const _RawSpotSave({
    Key key,
    this.action,
    @required this.url,
    @required this.name,
    @required this.label,
    this.addDivider = false,
  }) : super(key: key);

  final String url;
  final String name;
  final String label;
  final bool addDivider;
  final Widget action;

  static const rightPadding = 16.0;
  static const radius = 24.0;
  static const orPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderWidth = (action != null) ? 0.0 : 3.0;
    final innerBorderWidth = (action != null) ? 0.0 : 2.0;
    final offset = borderWidth + innerBorderWidth;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: rightPadding),
              child: Avatar(
                url: url,
                radius: radius,
                borderWidth: borderWidth,
                color: theme.primaryColor,
                elevation: 0,
                innerBorderWidth: innerBorderWidth,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(label),
                ],
              ),
            ),
            if (action != null)
              Padding(
                padding: const EdgeInsets.only(left: orPadding, right: orPadding),
                child: const Text("or"),
              ),
            if (action != null) action,
          ],
        ),
        if (addDivider)
          Divider(
            thickness: 2,
            indent: (radius * 2) + rightPadding + offset,
          ),
      ],
    );
  }
}
