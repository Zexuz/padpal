import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'event_filter_state.dart';

class Location {
  const Location({
    @required this.lat,
    @required this.lng,
    @required this.description,
  });

  final double lat;
  final double lng;
  final String description;
}

class EventFilterCubit extends Cubit<EventFilterState> {
  EventFilterCubit() : super(null) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    emit(
      EventFilterState(
        distance: prefs.getInt("event_filter:distance") ?? 10,
        timeSpan: RangeValues(
          prefs.getDouble("event_filter:time_span:start") ?? 1,
          prefs.getDouble("event_filter:time_span:end") ?? 3,
        ),
        location: Location(
          lat: prefs.getDouble("event_filter:location:lat") ?? 0,
          lng: prefs.getDouble("event_filter:location:lng") ?? 0,
          description: prefs.getString("event_filter:location:description") ?? "UNKNOWN",
        ),
      ),
    );
  }

  Future<void> _onChanged(EventFilterState state) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt("event_filter:distance", state.distance);
    prefs.setDouble("event_filter:time_span:start", state.timeSpan.start);
    prefs.setDouble("event_filter:time_span:end", state.timeSpan.end);
    prefs.setDouble("event_filter:location:lat", state.location.lat);
    prefs.setDouble("event_filter:location:lng", state.location.lng);
    prefs.setString("event_filter:location:description", state.location.description);

    emit(state);
  }

  void onTimeSpanChanged(RangeValues timeSpan) {
    _onChanged(state.copyWith(timeSpan: timeSpan));
  }

  void onDistanceChanged(int distance) {
    _onChanged(state.copyWith(distance: distance));
  }

  void onLocationChanged(double lat, double lng, String description) {
    _onChanged(state.copyWith(
        location: Location(
      lat: lat,
      lng: lng,
      description: description,
    )));
  }
}
