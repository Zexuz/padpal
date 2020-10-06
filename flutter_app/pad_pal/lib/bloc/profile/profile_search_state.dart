part of 'profile_search_cubit.dart';

class ProfileSearchState extends Equatable {
  ProfileSearchState({this.profiles, this.isLoading, this.selectedProfile});

  final List<Profile> profiles;
  final Profile selectedProfile;
  final bool isLoading;

  @override
  List<Object> get props => [profiles, isLoading, selectedProfile];

  ProfileSearchState copyWith({
    List<Profile> profiles,
    bool isLoading,
    Profile selectedProfile,
  }) {
    return ProfileSearchState(
      selectedProfile: selectedProfile ?? this.selectedProfile,
      profiles: profiles ?? this.profiles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
