part of 'event_filter_cubit.dart';

class EventFilterState extends Equatable {
  const EventFilterState({
    this.distance,
    this.timeSpan,
  });

  final int distance;
  final RangeValues timeSpan;

  @override
  List<Object> get props => [timeSpan, distance];

  EventFilterState copyWith({
    int distance,
    RangeValues timeSpan,
  }) {
    return EventFilterState(
      distance: distance ?? this.distance,
      timeSpan: timeSpan ?? this.timeSpan,
    );
  }
}
