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
            null,
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
}
