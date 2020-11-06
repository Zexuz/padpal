import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/screens/result/models/player.dart';

part 'result_state.dart';

enum Team { A, B }

class ResultCubit extends Cubit<ResultState> {
  ResultCubit({
    @required this.gameInfo,
  }) : super(ResultState(
          players: [
            Player(
              name: "Robin Edbom",
              url: 'https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg',
              key: ValueKey(0),
            ),
            Player(
              name: "David Joakim Jonsson",
              url: 'https://i.pravatar.cc/200?img=3',
              key: ValueKey(1),
            ),
            Player(
              name: "Eduardo Olabe",
              url: 'https://i.pravatar.cc/200?img=5',
              key: ValueKey(2),
            ),
            Player(
              name: "Oliver Hernaez",
              url: 'https://i.pravatar.cc/200?img=6',
              key: ValueKey(3),
            ),
          ],
          currentSetIndex: 0,
          sets: List.generate(3, (index) => List.generate(2, (index) => 3)),
        ));

  final GameInfo gameInfo;

  void next() {
    emit(state.copyWith(currentSet: state.currentSetIndex + 1));
  }

  void back() {
    emit(state.copyWith(currentSet: state.currentSetIndex - 1));
  }

  void resetSets() {
    emit(state.copyWith(
      currentSet: 0,
      sets: List.generate(3, (index) => List.generate(2, (index) => 3)),
    ));
  }

  void add(Team team) {
    _updateScore(team, 1);
  }

  void remove(Team team) {
    final teamIndex = team == Team.A ? 0 : 1;
    final otherTeamIndex = team == Team.A ? 1 : 0;
    final myScore = state.currentSet[teamIndex];
    final opponentsScore = state.currentSet[otherTeamIndex];

    if (opponentsScore == 7 && myScore == 5) {
      _updateScore(team, -1, -1);
    } else {
      _updateScore(team, -1);
    }
  }

  // Returns index of item with given key
  int _indexOfKey(Key key) {
    return state.players.indexWhere((d) => d.key == key);
  }

  void reorderDone(Key item) {
    final draggedItem = state.players[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.name}}");
  }

  bool reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final newList = [...state.players];

    final draggedItem = newList[draggingIndex];

    debugPrint("Reordering $item -> $newPosition");
    newList.removeAt(draggingIndex);
    newList.insert(newPositionIndex, draggedItem);

    emit(state.copyWith(players: newList));
    return true;
  }

  void _updateScore(Team team, int deltaMy, [int deltaOpponents = 0]) {
    final sets = List<List<int>>();

    for (var i = 0; i < state.sets.length; i++) {
      final set = state.sets[i];
      if (i != state.currentSetIndex) {
        sets.add(set);
        continue;
      }

      if (team == Team.A) {
        sets.add([set[0] + deltaMy, set[1] + deltaOpponents]);
      } else {
        sets.add([set[0] + deltaOpponents, set[1] + deltaMy]);
      }
    }

    emit(state.copyWith(sets: sets));
  }
}
