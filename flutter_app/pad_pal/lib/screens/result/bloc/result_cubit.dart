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
        ));

  final GameInfo gameInfo;

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
}
