
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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