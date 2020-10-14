part of 'event_filter_cubit.dart';

class EventFilterState extends Equatable {
  const EventFilterState({
    this.distance,
    this.timeSpan,
    this.location,
  });

  final int distance;
  final RangeValues timeSpan;
  final Location location;

  @override
  List<Object> get props => [timeSpan, distance, location];

  EventFilterState copyWith({
    int distance,
    RangeValues timeSpan,
    Location location,
  }) {
    return EventFilterState(
      distance: distance ?? this.distance,
      timeSpan: timeSpan ?? this.timeSpan,
      location: location ?? this.location,
    );
  }
}
