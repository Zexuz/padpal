import 'dart:async';
import 'dart:ffi';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/generated/auth_service.pbgrpc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:mockito/mockito.dart';

class MockResponseFuture<T> extends Mock implements ResponseFuture<T> {
  final T value;

  MockResponseFuture(this.value);

  Future<S> then<S>(FutureOr<S> onValue(T value), {Function onError}) =>
      Future.value(value).then(onValue, onError: onError);
}

class MockResponseThrowFuture<T> extends Mock implements ResponseFuture<T> {
  final GrpcError error;

  MockResponseThrowFuture(this.error);

  Future<S> then<S>(FutureOr<S> onValue(T value), {Function onError}) => throw error;
}

class MockAuthServiceClient extends Mock implements AuthServiceClient {}

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  const email = 'test@gmail.com';
  const password = 't0ps3cret42';

  group('AuthenticationRepository', () {
    AuthenticationRepository authenticationRepository;
    AuthServiceClient authServiceClient;
    TokenStorage tokenStorage;

    setUp(() {
      authServiceClient = MockAuthServiceClient();
      tokenStorage = MockTokenStorage();

      authenticationRepository =
          AuthenticationRepository(authServiceClient: authServiceClient, tokenStorage: tokenStorage);
    });

    test('creates instance internally when not injected', () {
      expect(() => AuthenticationRepository(), isNot(throwsException));
    });

    group('signUp', () {
      test('throws AssertionError when email is null', () {
        expect(
          () => authenticationRepository.login(
            email: null,
            password: password,
          ),
          throwsAssertionError,
        );
      });

      test('throws AssertionError when password is null', () {
        expect(
          () => authenticationRepository.login(
            email: email,
            password: null,
          ),
          throwsAssertionError,
        );
      });

      test('calls grpc method login and saves accessToken', () async {
        when(
          authServiceClient.login(any),
        ).thenAnswer(
          (_) => MockResponseFuture<LoginResponse>(LoginResponse()
            ..token = (OAuthToken()
              ..accessToken = "myAccessToken"
              ..expires = Int64.parseInt(1599562028.toString()))),
        );

        await authenticationRepository.login(email: email, password: password);
        verify(authServiceClient.login(LoginRequest()
              ..password = password
              ..email = email))
            .called(1);
        verify(tokenStorage.accessToken = AccessToken(
                token: "myAccessToken", expires: DateTime.fromMillisecondsSinceEpoch(1599562028 * 1000, isUtc: true)))
            .called(1);
      });

      test('succeeds when authServiceClient.login succeeds', () async {
        when(
          authServiceClient.login(any),
        ).thenAnswer(
          (_) => MockResponseFuture<LoginResponse>(LoginResponse()..token = (OAuthToken()..accessToken = "")),
        );

        expect(
          authenticationRepository.login(email: email, password: password),
          completes,
        );
      });

      test('throws SignUpFailure when authServiceClient.login throws', () async {
        when(
          authServiceClient.login(any),
        ).thenAnswer(
          (_) => MockResponseThrowFuture<LoginResponse>(GrpcError.deadlineExceeded()),
        );
        expect(
          authenticationRepository.login(email: email, password: password),
          throwsA(isA<SignUpFailure>()),
        );
      });

      test('return OAuthToken when authServiceClient.login succeeds', () async {
        when(
          authServiceClient.login(any),
        ).thenAnswer(
          (_) => MockResponseFuture<LoginResponse>(
              LoginResponse()..token = (OAuthToken()..accessToken = "someAccessToken")),
        );

        await authenticationRepository.login(email: email, password: password);

        // await expectLater(
        //     authenticationRepository.accessToken,
        //     emitsInOrder(const <String>["someAccessToken"])
        // );
      });
    });

    // group('user', () {
    //   test('emits empty string when token is null', () async {
    //     when(firebaseAuth.onAuthStateChanged).thenAnswer(
    //           (_) => Stream.value(null),
    //     );
    //     await expectLater(
    //       authenticationRepository.accessToken,
    //       emitsInOrder(anyNamed("named")),
    //     );
    //   });
    //
    //   test('emits User when firebase user is not null', () async {
    //     when(firebaseAuth.onAuthStateChanged).thenAnswer(
    //           (_) => Stream.value(MockFirebaseUser()),
    //     );
    //     await expectLater(
    //       authenticationRepository.user,
    //       emitsInOrder(const <User>[user]),
    //     );
    //   });
    // });
  });
}
