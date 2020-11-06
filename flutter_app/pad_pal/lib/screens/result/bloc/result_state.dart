part of 'result_cubit.dart';

enum SetState {
  unfinished,
  finished,
}

class ResultState extends Equatable {
  const ResultState({
    @required this.players,
    @required this.sets,
    @required this.currentSetIndex,
  });

  final List<Player> players;
  final List<List<int>> sets;
  final int currentSetIndex;

  List<Player> get teamA => players.take(2).toList();

  List<Player> get teamB => players.skip(2).take(2).toList();

  List<int> get currentSet => sets[currentSetIndex];

  bool isCurrentSetOver() {
    final max = math.max(sets[currentSetIndex][0], sets[currentSetIndex][1]);
    final min = math.min(sets[currentSetIndex][0], sets[currentSetIndex][1]);

    if (max == 7) {
      return true;
    }
    if (max == 6 && min < 5) {
      return true;
    }

    return false;
  }

  List<Player> winner() {
    int numberOfSetsWonA = 0;
    int numberOfSetsWonB = 0;

    for (var value in sets) {
      if (!isCurrentSetOver()) continue;

      if (value[0] > value[1]) {
        numberOfSetsWonA++;
      }
      if (value[0] < value[1]) {
        numberOfSetsWonB++;
      }
    }

    if (numberOfSetsWonA == 2) {
      return teamA;
    }
    if (numberOfSetsWonB == 2) {
      return teamB;
    }

    return null;
  }

  bool canAdd(Team team) {
    final teamIndex = team == Team.A ? 0 : 1;
    final otherTeamIndex = team == Team.A ? 1 : 0;
    final myScore = sets[currentSetIndex][teamIndex];
    final opponentsScore = sets[currentSetIndex][otherTeamIndex];

    if (myScore == 6 && opponentsScore < 5) return false;
    if (opponentsScore == 7) return false;
    if (myScore == 7) return false;

    return true;
  }

  bool canRemove(Team team) {
    final teamIndex = team == Team.A ? 0 : 1;
    final myScore = sets[currentSetIndex][teamIndex];
    return myScore != 0;
  }

  @override
  List<Object> get props => [players, sets, currentSetIndex];

  ResultState copyWith({
    List<Player> players,
    List<List<int>> sets,
    int currentSet,
  }) {
    return ResultState(
      players: players ?? this.players,
      sets: sets ?? this.sets,
      currentSetIndex: currentSet ?? this.currentSetIndex,
    );
  }
}
