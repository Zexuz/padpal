part of 'profile_search_cubit.dart';

class ProfileSearchState extends Equatable {
  ProfileSearchState({this.profiles, this.isLoading});

  final List<Profile> profiles;
  final bool isLoading;

  @override
  List<Object> get props => [profiles, isLoading];

  ProfileSearchState copyWith({
    List<Profile> profiles,
    bool isLoading,
  }) {
    return ProfileSearchState(
      profiles: profiles ?? this.profiles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
