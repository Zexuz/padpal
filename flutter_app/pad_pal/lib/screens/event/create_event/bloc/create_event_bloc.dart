import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:game_repository/game_repository.dart';
import 'package:game_repository/generated/game_v1/game_service.pb.dart';
import 'package:game_repository/generated/game_v1/game_service.pbenum.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit({@required GameRepository gameRepository})
      : assert(gameRepository != null),
        _gameRepo = gameRepository,
        super(CreateEventState(
          isNextEnabled: true,
          currentStep: 0,
        ));

  final GameRepository _gameRepo;

  void setIsNextEnable(bool isEnabled) {
    if (isEnabled == state.isNextEnabled) return;

    emit(state.copyWith(isNextEnabled: isEnabled));
  }

  Future<void> next() async {
    if (state.currentStep == 2) {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        final publicInfo = PublicGameInfo()
          ..courtType = state.courtType
          ..startTime = Int64(state.matchStartDate.millisecondsSinceEpoch ~/ 1000)
          ..durationInMinutes = state.matchDuration.inMinutes
          ..pricePerPerson = state.pricePerPerson
          ..location = (PadelCenter()
            ..name = state.locationName
            ..point = (Point()
              ..latitude = state.locationLatLng.latitude
              ..longitude = state.locationLatLng.longitude));

        final privateInfo = PrivateGameInfo()
          ..additionalInformation = state.additionalInformation
          ..courtName = state.courtNumber;

        await _gameRepo.createGame(publicInfo, privateInfo);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        rethrow;
      }

      return;
    }

    // emit(state.copyWith(currentStep: state.currentStep + 1, isNextEnabled: false));
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  Future<bool> back() {
    if (state.currentStep >= 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
      return Future.value(false);
    }
    return Future.value(true);
  }

  void startMatchTimeChanged(DateTime start, Duration duration) {
    emit(state.copyWith(
      matchStartDate: start,
      matchDuration: duration,
    ));
  }

  void locationChanged(String name, LatLng latLng) {
    emit(state.copyWith(locationLatLng: latLng, locationName: name));
  }

  void courtNumberChanged(String value) {
    emit(state.copyWith(courtNumber: value));
  }

  void courtTypeChanged(CourtType courtType) {
    emit(state.copyWith(courtType: courtType));
  }

  void pricePerPersonChanged(String priceStr) {
    // TODO validation!
    // If it fails, show a toast or error msg!
    final price = int.parse(priceStr);

    emit(state.copyWith(pricePerPerson: price));
  }

  void additionalInformationChanged(String info) {
    emit(state.copyWith(additionalInformation: info));
  }
}
