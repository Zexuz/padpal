import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );

    _authenticationRepository.init();
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUsername();
        return user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  final String _token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJleHAiOiIxNTk5Njc1MDQwIiwic3ViIjoiMiJ9.CWnDrLtuz9j5fzwooJDyFTR3ysT9ieSUuQUYsmIL3wouZec35TsDiApi6rrbvYJN-cOkwmc4q8ZG4e_zUty740V2DVvcLXz_hNq1r8jvs-GikdoRa0GV9zgErKmCopOhgfyERZ7EXBQ1jEccptwkcWtN1aLdcVzM3YQynBsZFdbfGuxtJuNJysO94z86eH6q9aRMsxX17CQJQFzcQEvXFsSYYsFKDm8eqYFpaL7qoy7OTlspO9sQRoBuo4PlETXb_LeQZdmF1xnWUAgebWz63z4Whm7XwvRCXMZ2BglwKkzzSJ022AUw7vaBM-5zKz0O3q1R7fjCk-cAq1MbgqOS6w';

  Future<String> _tryGetUsername() async {
    return (await _userRepository.me(_token)).username;
  }
}
