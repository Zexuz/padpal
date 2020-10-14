import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/generated/game_v1/game_service.pbenum.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_repository/social_repository.dart';
import 'package:social_repository/src/social_repository.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit({@required SocialRepository socialRepository})
      : assert(socialRepository != null),
        _socialRepo = socialRepository,
        super(CreateEventState(
          isNextEnabled: true,
          currentStep: 0,
        ));

  final SocialRepository _socialRepo;

  void next() {
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
