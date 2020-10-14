import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void onNext() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  Future<bool> onBack() {
    if (state.currentStep >= 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
      return Future.value(false);
    }
    return Future.value(true);
  }
}
