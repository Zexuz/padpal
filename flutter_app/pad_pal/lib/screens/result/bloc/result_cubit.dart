import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/screens/result/models/player.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit({
    @required this.gameInfo,
  }) : super(ResultState(
          teamA: <Player>[
            Player(
              name: "Robin Edbom",
              url: 'https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg',
            ),
            Player(
              name: "David Joakim Jonsson",
              url: 'https://i.pravatar.cc/200?img=3',
            ),
          ],
          teamB: <Player>[
            Player(
              name: "Eduardo Olabe",
              url: 'https://i.pravatar.cc/200?img=5',
            ),
            Player(
              name: "Oliver Hernaez",
              url: 'https://i.pravatar.cc/200?img=6',
            ),
          ],
          playersInMatchV1: [
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
        ));

  final GameInfo gameInfo;

  onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    final teamA = [...state.teamA];
    final teamB = [...state.teamB];
    final itemToMove = (oldListIndex == 0 ? teamA : teamB).removeAt(oldItemIndex);
    (newListIndex == 0 ? teamA : teamB).insert(newItemIndex, itemToMove);
    emit(state.copyWith(teamA: teamA, teamB: teamB));
  }

  // Returns index of item with given key
  int _indexOfKey(Key key) {
    return state.playersInMatchV1.indexWhere((d) => d.key == key);
  }

  void reorderDone(Key item) {
    final draggedItem = state.playersInMatchV1[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.name}}");
  }

  bool reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final newList = [...state.playersInMatchV1];

    final draggedItem = newList[draggingIndex];

    debugPrint("Reordering $item -> $newPosition");
    newList.removeAt(draggingIndex);
    newList.insert(newPositionIndex, draggedItem);

    emit(state.copyWith(playersInMatchV1: newList));
    return true;
  }
}
