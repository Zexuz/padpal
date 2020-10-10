import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/theme.dart';

class CreateEventPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateEventPage());
  }

  @override
  _CreateEventWizardState createState() => _CreateEventWizardState();
}

class _CreateEventWizardState extends State<CreateEventPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final steps = [
      CreateEventAddPlayers(),
      Text("NR 2"),
      Text("NR 3"),
    ];

    return WillPopScope(
      onWillPop: () {
        if (currentPage >= 1) {
          setState(() => currentPage--);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Create event",
          leading: currentPage > 0
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => setState(() => currentPage--),
                )
              : Container(),
          actions: [
            FlatButton(
              onPressed: () => {Navigator.of(context).pop<void>()},
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              steps[currentPage],
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Progress(currentPage: currentPage),
                  const SizedBox(height: 12),
                  ButtonLargePrimary(
                    text: "Next",
                    onPressed: () => {setState(() => currentPage++)},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({
    Key key,
    @required this.currentPage,
  }) : super(key: key);

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final doneColor = Theme.of(context).primaryColor;
    final todoColor = Theme.of(context).primaryColor.withOpacity(0.12);

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 8,
              color: doneColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 8,
              color: currentPage >= 1 ? doneColor : todoColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 8,
              color: currentPage >= 2 ? doneColor : todoColor,
            ),
          ),
        ),
      ],
    );
  }
}

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
        Text("Players", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Text("Lorem ipsom dolar sit amet", style: theme.textTheme.bodyText2.copyWith(color: AppTheme.lightGrayText)),
        const SizedBox(height: 38),
        Container(
          child: _RawSpot(
            avatar: Avatar(
              url: url,
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
