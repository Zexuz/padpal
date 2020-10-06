import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_repository/social_repository.dart';
import 'package:social_repository/src/social_repository.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit({@required SocialRepository socialRepository})
      : assert(socialRepository != null),
        _socialRepo = socialRepository,
        super(MeState(isLoading: false, me: null)) {
    getMyProfile();
  }

  final SocialRepository _socialRepo;

  Future<void> getMyProfile() async {
    emit(state.copyWith(isLoading: true));
    var me = await _socialRepo.getMyProfile();
    emit(state.copyWith(me: me, isLoading: false));
  }
}
