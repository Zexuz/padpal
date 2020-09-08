import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pad_pal/authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    when(authenticationRepository.status)
        .thenAnswer((_) => const Stream.empty());
  });

  group('AuthenticationBloc', () {
    test('throws when authenticationRepository is null', () {
      expect(
            () => AuthenticationBloc(
          authenticationRepository: null,
        ),
        throwsAssertionError,
      );
    });

    test('initial state is AuthenticationState.unknown', () {
      final authenticationBloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      );
      expect(authenticationBloc.state, const AuthenticationState.unknown());
      authenticationBloc.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is unauthenticated',
      build: () {
        when(authenticationRepository.status).thenAnswer(
              (_) => Stream.value(AuthenticationStatus.unauthenticated),
        );
        return AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      expect: const <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when status is authenticated',
      build: () {
        when(authenticationRepository.status).thenAnswer(
              (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        return AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      expect: const <AuthenticationState>[
        AuthenticationState.authenticated("myUsername")
      ],
    );
  });

  group('AuthenticationStatusChanged', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when status is authenticated',
      build: () {
        when(authenticationRepository.status).thenAnswer(
              (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        return AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      ),
      expect: const <AuthenticationState>[
        AuthenticationState.authenticated("myUsername")
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is unauthenticated',
      build: () {
        when(authenticationRepository.status).thenAnswer(
              (_) => Stream.value(AuthenticationStatus.unauthenticated),
        );
        return AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.unauthenticated),
      ),
      expect: const <AuthenticationState>[
        AuthenticationState.unauthenticated()
      ],
    );

    // blocTest<AuthenticationBloc, AuthenticationState>(
    //   'emits [unauthenticated] when status is authenticated but getUser fails',
    //   build: () {
    //     when(userRepository.getUser()).thenThrow(Exception('oops'));
    //     return AuthenticationBloc(
    //       authenticationRepository: authenticationRepository,
    //       userRepository: userRepository,
    //     );
    //   },
    //   act: (bloc) => bloc.add(
    //     const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
    //   ),
    //   expect: const <AuthenticationState>[
    //     AuthenticationState.unauthenticated()
    //   ],
    // );

    // blocTest<AuthenticationBloc, AuthenticationState>(
    //   'emits [unauthenticated] when status is authenticated '
    //       'but getUser returns null',
    //   build: () {
    //     when(userRepository.getUser()).thenAnswer((_) async => null);
    //     return AuthenticationBloc(
    //       authenticationRepository: authenticationRepository,
    //       userRepository: userRepository,
    //     );
    //   },
    //   act: (bloc) => bloc.add(
    //     const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
    //   ),
    //   expect: const <AuthenticationState>[
    //     AuthenticationState.unauthenticated()
    //   ],
    // );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unknown] when status is unknown',
      build: () {
        when(authenticationRepository.status).thenAnswer(
              (_) => Stream.value(AuthenticationStatus.unknown),
        );
        return AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.unknown),
      ),
      expect: const <AuthenticationState>[
        AuthenticationState.unknown(),
      ],
    );
  });

  group('AuthenticationLogoutRequested', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'calls logOut on authenticationRepository '
          'when AuthenticationLogoutRequested is added',
      build: () {
        return AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      act: (bloc) => bloc.add(AuthenticationLogoutRequested()),
      verify: (_) {
        verify(authenticationRepository.logOut()).called(1);
      },
    );
  });
}