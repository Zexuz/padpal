part of 'result_cubit.dart';

class ResultState extends Equatable {
  const ResultState({
    @required this.teamA,
    @required this.teamB,
    @required this.playersInMatchV1,
  });

  final List<Player> teamA;
  final List<Player> teamB;
  final List<Player> playersInMatchV1;

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
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      playersInMatchV1: playersInMatchV1 ?? this.playersInMatchV1,
    );
  }
}
