import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/generated/user_service.pbgrpc.dart';
import 'package:user_repository/generated/user_service.pbgrpc.dart' as pb;
import 'package:user_repository/src/user_repository.dart';

class MockUserServiceClient extends Mock implements UserServiceClient {}
// TODO Move to test_helpers
class MockResponseFuture<T> extends Mock implements ResponseFuture<T> {
  final T value;

  MockResponseFuture(this.value);

  Future<S> then<S>(FutureOr<S> onValue(T value), {Function onError}) =>
      Future.value(value).then(onValue, onError: onError);
}

class MockTokenManager extends Mock implements TokenManager {}

void main() {
  group('UserRepository', () {
    UserRepository userRepository;
    UserServiceClient userServiceClient;
    TokenManager tokenManager;

    setUp(() {
      userServiceClient = MockUserServiceClient();
      tokenManager = MockTokenManager();

      userRepository = UserRepository(userServiceClient: userServiceClient, tokenManager: tokenManager);
    });

    group('Me', () {
      test('should get my profile info', () async {
        when(userServiceClient.me(any, options: anyNamed('options'))).thenAnswer(
          (_) => MockResponseFuture<MeResponse>(MeResponse()
            ..me = (pb.Me()
              ..username = "zexuz"
              ..email = "robin@mkdir.se"
              ..firstName = "robin"
              ..lastName = "edbom")),
        );

        final accessToken = AccessToken(token: "myAccessToken", expires: DateTime.now().add(Duration(minutes: 30)));
        when(tokenManager.accessToken).thenReturn(accessToken);

        var res = await userRepository.me();

        expect(res.username, "zexuz");
        expect(res.email, "robin@mkdir.se");
        expect(res.firstName, "robin");
        expect(res.lastName, "edbom");

        var verification = verify(userServiceClient.me(any, options: captureAnyNamed('options')));
        expect((verification.captured[0] as CallOptions).metadata, {'Authorization': 'Bearer myAccessToken'});
      });
    });
  });
}