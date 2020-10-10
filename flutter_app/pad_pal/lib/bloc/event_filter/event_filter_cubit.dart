import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_filter_state.dart';

class EventFilterCubit extends Cubit<EventFilterState> {
  EventFilterCubit() : super(EventFilterState(distance: 10, timeSpan: RangeValues(1, 3)));

  void onTimeSpanChanged(RangeValues timeSpan) {
    emit(state.copyWith(timeSpan: timeSpan));
  }

  void onDistanceChanged(int distance) {
    emit(state.copyWith(distance: distance));
  }
}
