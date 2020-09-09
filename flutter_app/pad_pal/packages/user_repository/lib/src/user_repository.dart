import 'package:grpc/grpc.dart';
import 'package:user_repository/generated/user_service.pbgrpc.dart';

class Me {
  String username;
  String email;
  String firstName;
  String lastName;
}

class UserRepository {
  const UserRepository({UserServiceClient userServiceClient}) : _userServiceClient = userServiceClient;

  final UserServiceClient _userServiceClient;

  Future<Me> me(String accessToken) async {
    final callOptions = CallOptions(metadata: {'Authentication': "Bearer '$accessToken'"});
    final call = _userServiceClient.me(MeRequest(), options: callOptions);

    final protoRes = await call;
    return Me()
      ..email = protoRes.me.email
      ..username = protoRes.me.username
      ..firstName = protoRes.me.firstName
      ..lastName = protoRes.me.lastName;
  }
}
