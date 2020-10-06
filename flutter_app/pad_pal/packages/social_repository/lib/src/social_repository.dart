import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:social_repository/generated/social_v1/social_service.pbgrpc.dart';

class Profile {
  String name;
  String rank;
  int userId;
  int wins;
  int losses;
  List<int> friends;
  String imageUrl;
  String location;
}

class SocialRepository {
  SocialRepository({SocialClient socialClient, TokenManager tokenManager})
      : _chatServiceClient = socialClient ?? SocialClient(GrpcChannelFactory().createChannel()),
        _tokenManager = tokenManager ?? TokenManager();

  final SocialClient _chatServiceClient;
  final TokenManager _tokenManager;

  final StreamController<String> streamController = StreamController();

  Future<void> sendMessage(String message) async {
    final call = _chatServiceClient.sendMessage(SendMessageRequest()..content = message);
    await call;
  }

  Future<List<Profile>> searchForProfile(String rawStr) async {
    final searchTerm = rawStr.trim();
    if (searchTerm.length < 3) {
      return List.empty();
    }

    final callOptions = CallOptions(metadata: {'Authorization': "Bearer ${_tokenManager.accessToken.token}"});
    final request = SearchForProfileRequest()..searchTerm = searchTerm;

    final call = _chatServiceClient.searchForProfile(request, options: callOptions);
    var response = await call;
    return response.profiles
        .map((e) => Profile()
          ..name = e.name
          ..userId = e.userId
          ..rank = "Beginner + + +"
          ..friends = e.friends
          ..location = "Göteborg"
          ..imageUrl = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg"
          ..losses = 25
          ..wins = 75)
        .toList();
  }

  Future<Profile> getMyProfile() async {
    final callOptions = CallOptions(metadata: {'Authorization': "Bearer ${_tokenManager.accessToken.token}"});
    final request = MyProfileRequest();

    final call = _chatServiceClient.myProfile(request, options: callOptions);
    var response = await call;
    return Profile()
      ..name = response.me.name
      ..rank = "Beginner + + +"
      ..location = "Göteborg"
      ..friends = List.empty()
      ..imageUrl = response.me.imgUrl
      ..losses = 25
      ..wins = 75;
  }
}
