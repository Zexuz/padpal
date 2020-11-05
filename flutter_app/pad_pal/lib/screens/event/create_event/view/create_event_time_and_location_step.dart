import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pad_pal/components/components.dart';

import '../bloc/create_event_bloc.dart';

class CreateEventTimeAndLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateEventCubit, CreateEventState>(
      listener: (context, state) {
        // print("HJEll");
        // context.bloc<CreateEventCubit>().setIsNextEnable(state.matchStartDate != null &&
        //     state.matchDuration != null &&
        //     state.locationLatLng != null &&
        //     state.courtNumber != null);
      },
      child: Column(
        children: [
          _DateAndTimeInput(),
          _LocationInput(),
          _CourtInput(),
        ],
      ),
    );
  }
}

class _LocationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) => previous.locationName != current.locationName,
      builder: (context, state) {
        return GoogleSearchInput(
          initialValue: state.locationName,
          onChanged: (lat, lng, name) => context.bloc<CreateEventCubit>().locationChanged(name, LatLng(lat, lng)),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Location',
          ),
        );
      },
    );
  }
}

class _CourtInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) => previous.courtNumber != current.courtNumber,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.courtNumber,
          onChanged: (value) => context.bloc<CreateEventCubit>().courtNumberChanged(value),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Court number',
            hintText: "e.g. 9 (hall B)",
          ),
        );
      },
    );
  }
}

class MatchTime {
  DateTime start;
  Duration duration;
}

class _DateAndTimeInput extends StatelessWidget {
  static const maxTimeSpan = Duration(days: 14);
  final formatDateTime = DateFormat("EEE, MMM d, HH.mm");

  final formatEndTime = DateFormat("-HH.mm");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) => previous.matchStartDate != current.matchStartDate,
      builder: (context, state) {
        final eventCubit = context.bloc<CreateEventCubit>();
        return Column(
          children: <Widget>[
            FlatButton(
                color: Colors.red,
                onPressed: () async {
                  var time = await getStartDateTimeAndDuration(context);
                  if (time != null) {
                    eventCubit.startMatchTimeChanged(time.start, time.duration);
                  }
                },
                child: Text("SetDateTime")),
            if (state.matchStartDate != null)
              Text(
                  "${formatDateTime.format(state.matchStartDate)}${formatEndTime.format(state.matchStartDate.add(state.matchDuration))}"),
          ],
        );
      },
    );
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
