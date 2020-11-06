part of 'result_cubit.dart';

class ResultState extends Equatable {
  const ResultState({
    @required this.playersInMatchV1,
  });

  final List<Player> playersInMatchV1;

  List<Player> get teamA => playersInMatchV1.take(2).toList();

  List<Player> get teamB => playersInMatchV1.skip(2).take(2).toList();

  bool get isTeamSetupValid => teamA.length == 2 && teamB.length == 2;

  @override
  List<Object> get props => [
        teamA,
        teamB,
        playersInMatchV1,
      ];

  ResultState copyWith({
    List<Player> teamA,
    List<Player> teamB,
    List<Player> playersInMatchV1,
  }) {
    return ResultState(
      playersInMatchV1: playersInMatchV1 ?? this.playersInMatchV1,
    );
  }
}
