import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/theme.dart';
import 'package:intl/intl.dart';

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
      CreateEventTimeAndLocation(),
      CreateEventOtherInformation(),
    ];

    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () {
        if (currentPage >= 1) {
          setState(() => currentPage--);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
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
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Players", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        Text("Lorem ipsom dolar sit amet",
                            style: theme.textTheme.bodyText2.copyWith(color: AppTheme.lightGrayText)),
                        const SizedBox(height: 38),
                        steps[currentPage],
                        Expanded(child: Container()),
                        const SizedBox(height: 24),
                        _Progress(currentPage: currentPage),
                        const SizedBox(height: 12),
                        ButtonLargePrimary(
                          text: "Next",
                          onPressed: () => {setState(() => currentPage++)},
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CreateEventOtherInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CourtTypeInput(),
        const SizedBox(
          height: 48,
        ),
        _PriceInput(),
        const SizedBox(
          height: 48,
        ),
        TextFormField(
          maxLines: 8, // TODO make some logging and check if this needs to be bigger!
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'Leave a message',
            hintText: "This text will not be visible to people outside of this event"
          ),
        )
      ],
    );
  }
}

class _CourtTypeInput extends StatefulWidget {
  @override
  __CourtTypeInputState createState() => __CourtTypeInputState();
}

class __CourtTypeInputState extends State<_CourtTypeInput> {
  String groupValue = "";

  bool someBooleanValue = false;

  _onRadioButtonTap(String newValue) {
    if (newValue == null) return;
    setState(() {
      groupValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioButtonInput<String>(
          text: "Indoors",
          value: "indoors",
          groupValue: groupValue,
          onChanged: _onRadioButtonTap,
        ),
        const SizedBox(height: 12),
        RadioButtonInput<String>(
          text: "Outdoors",
          value: "outdoors",
          groupValue: groupValue,
          onChanged: _onRadioButtonTap,
        ),
      ],
    );
  }
}

class ProgressContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
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

class CreateEventTimeAndLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateAndTimeInput(),
        _LocationInput(),
        _CourtInput(),
      ],
    );
  }
}

class _LocationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Location',
      ),
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "kr",
        border: OutlineInputBorder(),
        labelText: 'Price per person',
      ),
    );
  }
}

class _CourtInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Court number', hintText: "e.g. 9 (hall B)"),
    );
  }
}

class MatchTime {
  DateTime start;
  Duration duration;
}

class _DateAndTimeInput extends StatefulWidget {
  static const maxTimeSpan = Duration(days: 14);

  @override
  __DateAndTimeInputState createState() => __DateAndTimeInputState();
}

class __DateAndTimeInputState extends State<_DateAndTimeInput> {
  final formatDateTime = DateFormat("EEE, MMM d, HH.mm");

  final formatEndTime = DateFormat("-HH.mm");

  MatchTime time;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FlatButton(
          color: Colors.red,
          onPressed: () async {
            var time = await getStartDateTimeAndDuration(context);
            if (time != null) {
              setState(() {
                this.time = time;
              });
            }
          },
          child: Text("SetDateTime")),
      if (time != null)
        Text("${formatDateTime.format(time.start)}${formatEndTime.format(time.start.add(time.duration))}"),
    ]);
  }

  Future<MatchTime> getStartDateTimeAndDuration(BuildContext context) async {
    final currentValue = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: currentValue ?? DateTime.now(),
      lastDate: DateTime.now().add(_DateAndTimeInput.maxTimeSpan),
    );
    if (date == null) return null;
    final baseTime = currentValue ?? DateTime.now();

    final startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(baseTime),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (startTime == null) return null;

    final duration = await showDurationDialog(context);
    return MatchTime()
      ..start = date.add(Duration(hours: startTime.hour, minutes: startTime.minute))
      ..duration = duration;
  }

  Future<Duration> showDurationDialog(BuildContext context) async {
    return await showDialog<Duration>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('How long how you booked?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, Duration(minutes: 60));
                      },
                      child: Text("60 min")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, Duration(minutes: 90));
                      },
                      child: Text("90 min"))
                ],
              ),
            ],
          ),
        );
      },
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
