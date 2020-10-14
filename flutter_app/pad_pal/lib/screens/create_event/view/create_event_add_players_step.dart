
import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';

class CreateEventAddPlayers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
    const radius = 24.0;

    const offset = (radius * 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: _RawSpot(
            avatar: Avatar(
              url: "",
              fallback: "AB",
              radius: radius,
              borderWidth: 3.0,
              color: theme.primaryColor,
              elevation: 0,
              innerBorderWidth: 2.0,
            ),
            name: "Anton Brownstein",
            label: "Beginner",
            offset: offset + 5.0,
            addDivider: true,
          ),
          transform: Matrix4.translationValues(-5.0, 0, 0.0),
        ),
        _RawSpot(
          avatar: Avatar(
            url: url,
            radius: radius,
            borderWidth: 0,
            color: theme.primaryColor,
            elevation: 0,
            innerBorderWidth: 0,
            fallback: "AG",
          ),
          name: "Andries Grootoonk",
          label: "Beginner",
          action: ButtonSmallSecondary(
            stretch: false,
            onPressed: () => {},
            text: "Remove",
            isDisabled: false,
          ),
          addDivider: true,
          offset: offset,
        ),
        _RawSpot(
          avatar: DottedAvatar(
            radius: radius,
          ),
          name: "Player 3",
          label: "Free spot",
          action: ButtonSmallPrimary(
            stretch: false,
            onPressed: () => {},
            text: "Add friend",
            isDisabled: false,
          ),
          addDivider: true,
          offset: offset,
        ),
        _RawSpot(
          avatar: DottedAvatar(
            radius: radius,
          ),
          name: "Player 4",
          label: "Free spot",
          action: ButtonSmallPrimary(
            stretch: false,
            onPressed: () => {},
            text: "Add friend",
            isDisabled: false,
          ),
          addDivider: false,
          offset: offset,
        ),
      ],
    );
  }
}

class _RawSpot extends StatelessWidget {
  const _RawSpot({
    Key key,
    this.action,
    @required this.avatar,
    @required this.name,
    @required this.label,
    @required this.offset,
    this.addDivider = false,
  }) : super(key: key);

  final Widget action;
  final Widget avatar;
  final String name;
  final String label;
  final bool addDivider;
  final double offset;

  static const rightPadding = 16.0;
  static const orPadding = 16.0;
  static const dividerHeight = 24.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: rightPadding),
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
            height: dividerHeight,
            indent: offset + rightPadding,
          ),
      ],
    );
  }
}
