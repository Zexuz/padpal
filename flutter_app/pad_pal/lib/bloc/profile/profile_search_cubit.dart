import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_repository/social_repository.dart';
import 'package:social_repository/src/social_repository.dart';

part 'profile_search_state.dart';

class ProfileSearchCubit extends Cubit<ProfileSearchState> {
  ProfileSearchCubit({@required SocialRepository socialRepository})
      : assert(socialRepository != null),
        _socialRepo = socialRepository,
        super(ProfileSearchState(profiles: List.empty(), isLoading: false));

  final SocialRepository _socialRepo;

  Future<void> onSearchTermChange(String searchTerm) async {
    emit(state.copyWith(isLoading: true));
    var profiles = await _socialRepo.searchForProfile(searchTerm);
    emit(state.copyWith(profiles: profiles, isLoading: false));
  }
}
