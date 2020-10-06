part of 'me_cubit.dart';

class MeState extends Equatable {
  MeState({this.me, this.isLoading});

  final Profile me;
  final bool isLoading;

  @override
  List<Object> get props => [me, isLoading];

  MeState copyWith({
    bool isLoading,
    Profile me,
  }) {
    return MeState(
      me: me ?? this.me,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
