import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_repository/social_repository.dart';
import 'package:social_repository/src/social_repository.dart';

part 'profile_search_state.dart';

class ProfileSearchCubit extends Cubit<ProfileSearchState> {
  ProfileSearchCubit({
    @required SocialRepository socialRepository,
    bool onlySearchForFriends = false,
  })  : assert(socialRepository != null),
        _socialRepo = socialRepository,
        _onlySearchForFriends = onlySearchForFriends,
        super(ProfileSearchState(profiles: List.empty(), isLoading: false, selectedProfile: null));

  final SocialRepository _socialRepo;
  final bool _onlySearchForFriends;

  Future<void> onSearchTermChange(String searchTerm) async {
    emit(state.copyWith(isLoading: true));
    var profiles = await _socialRepo.searchForProfile(searchTerm, _onlySearchForFriends);
    emit(state.copyWith(profiles: profiles, isLoading: false));
  }

  void setProfile(Profile profile) {
    emit(state.copyWith(selectedProfile: profile));
  }
}
