part of 'event_cubit.dart';

class EventState extends Equatable {
  EventState({this.games}) {
    print("length ${games.length}");
  }

  final List<GameInfo> games;

  @override
  List<Object> get props => [games];

  EventState copyWith({
    List<GameInfo> games,
  }) {
    return EventState(games: games ?? this.games);
  }
}
