import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  EventFilterCubit() : super(EventFilterState(distance: 10, timeSpan: RangeValues(1, 3), location: Location(lat: 0, lng: 0, description: "UNKNOWN")));

  void onTimeSpanChanged(RangeValues timeSpan) {
    emit(state.copyWith(timeSpan: timeSpan));
  }

  void onDistanceChanged(int distance) {
    emit(state.copyWith(distance: distance));
  }

  void onLocationChanged(double lat, double lng, String description) {
    emit(state.copyWith(
        location: Location(
      lat: lat,
      lng: lng,
      description: description,
    )));
  }
}
