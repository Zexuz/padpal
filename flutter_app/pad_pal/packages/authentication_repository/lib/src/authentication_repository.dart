import 'dart:async';

import 'package:authentication_repository/generated/auth_service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {
  // TODO implement error codes here
}

class AuthenticationRepository {
  AuthenticationRepository({AuthServiceClient authServiceClient}) : _authServiceClient = authServiceClient;

  AuthServiceClient _authServiceClient;
  final _controller = StreamController<String>();

  Stream<String> get accessToken {
    return _controller.stream;
  }

  Future<void> login({@required email, @required String password}) async {
    assert(email != null);
    assert(password != null);

    var call = _authServiceClient.login(LoginRequest()
      ..password = password
      ..email = email);

    // var trailers = await res.trailers;

    try {
      var res = await call;
      _controller.sink.add(res.token.accessToken);
    } on GrpcError catch (_) {
      throw SignUpFailure();
      // if (!_canHandel(e)) rethrow;
      // _handel(e);
    }
  }

  // bool _canHandel(GrpcError e) {
  //   return true;
  // }
  //
  // void _handel(GrpcError e) {
  //   throw SignUpFailure();
  // }

  Future<void> dispose() async {
    await _controller.close();
  }
}

// import 'dart:async';
//
// import 'package:meta/meta.dart';
// import 'package:grpc/grpc.dart';
//
// import '../generated/auth_service.pbgrpc.dart';
//
// enum AuthenticationStatus { unknown, authenticated, unauthenticated }
//
// class AuthenticationRepository {
//   AuthenticationRepository({
//     AuthServiceClient authServiceClient,
//   }) : _authServiceClient = authServiceClient ??
//       AuthServiceClient(
//           ClientChannel('192.168.10.240',
//               port: 5001, options: const ChannelOptions(credentials: ChannelCredentials.insecure())),
//           options: CallOptions(timeout: Duration(seconds: 30)));
//
//   final _controller = StreamController<AuthenticationStatus>();
//   final AuthServiceClient _authServiceClient;
//
//   Stream<AuthenticationStatus> get status async* {
//     await Future<void>.delayed(const Duration(seconds: 1));
//     yield AuthenticationStatus.unauthenticated;
//     yield* _controller.stream;
//   }
//
//   Future<void> logIn({
//     @required String username,
//     @required String password,
//   }) async {
//     assert(username != null);
//     assert(password != null);
//
//     var res = await _authServiceClient.login(LoginRequest()
//       ..email = "r@a.com"
//       ..password = "pw");
//     print(res.token.accessToken);
//
//     await Future.delayed(
//       const Duration(milliseconds: 300),
//           () => _controller.add(AuthenticationStatus.authenticated),
//     );
//   }
//
//   void logOut() {
//     _controller.add(AuthenticationStatus.unauthenticated);
//   }
//
//   void dispose() => _controller.close();
// }
