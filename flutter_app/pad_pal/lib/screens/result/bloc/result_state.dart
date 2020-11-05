part of 'result_cubit.dart';

class ResultState extends Equatable {
  const ResultState({
    @required this.teamA,
    @required this.teamB,
  });

  final List<Player> teamA;
  final List<Player> teamB;

  bool get isTeamSetupValid => teamA.length == 2 && teamB.length == 2;

  @override
  List<Object> get props => [
        teamA,
        teamB,
      ];

  ResultState copyWith({
    List<Player> teamA,
    List<Player> teamB,
  }) {
    return ResultState(
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
    );
  }
}
