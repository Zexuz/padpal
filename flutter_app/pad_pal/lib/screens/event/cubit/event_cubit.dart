import 'package:fixnum/fixnum.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:game_repository/generated/game_v1/game_service.pb.dart';
import 'package:pad_pal/bloc/event_filter/event_filter_cubit.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit({@required GameRepository gameRepository})
      : assert(gameRepository != null),
        _gameRepo = gameRepository,
        super(EventState(games: List.empty()));

  final GameRepository _gameRepo;

  Future<void> findGames(EventFilterState eventFilterState) async {
    debugPrint("filterLocation ${eventFilterState.location}");

    final filter = GameFilter()
      ..distance = eventFilterState.distance
      ..center = (Point()
        ..longitude = eventFilterState.location.lng
        ..latitude = eventFilterState.location.lat)
      ..timeOffset = (GameFilter_TimeOffset()
        ..start = Int64(DateTime.now()
                .toUtc()
                .add(Duration(days: eventFilterState.timeSpan.start.toInt()))
                .millisecondsSinceEpoch ~/
            1000)
        ..end = Int64(
            DateTime.now().toUtc().add(Duration(days: eventFilterState.timeSpan.end.toInt())).millisecondsSinceEpoch ~/
                1000));

    var games = await _gameRepo.findGames(filter);
    emit(state.copyWith(games: games));
  }
}
