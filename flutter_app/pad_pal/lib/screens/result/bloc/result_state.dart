part of 'result_cubit.dart';

class ResultState extends Equatable {
  const ResultState({
    @required this.players,
  });

  final List<Player> players;

  List<Player> get teamA => players.take(2).toList();

  List<Player> get teamB => players.skip(2).take(2).toList();

  @override
  List<Object> get props => [players];

  ResultState copyWith({List<Player> players}) {
    return ResultState(
      players: players ?? this.players,
    );
  }
}
