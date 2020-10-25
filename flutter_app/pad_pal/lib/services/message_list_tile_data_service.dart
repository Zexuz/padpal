import 'package:game_repository/generated/common_v1/models.pb.dart' as game;
import 'package:pad_pal/screens/messages/view/message_form.dart';
import 'package:social_repository/generated/social_v1/social_service.pb.dart';

class MessageListTileDataService {
  MessageListTileData Build(ChatRoom room) {
    return MessageListTileData(
      title: _buildTitle(room),
      users: _getUsersWithProfilePictures(room),
      unread: false,
      subtitle: _getSubtitle(room),
    );
  }

  String _buildTitle(ChatRoom room) {
    final buffer = StringBuffer();

    if (room.participants.length == 2) {
      return room.participants[1].name;
    }

    for (var i = 0; i < room.participants.length - 1; i++) {
      buffer.write(_getFirstName(room.participants[i].name));

      if (i == room.participants.length - 2) continue;

      buffer.write(", ");
    }

    buffer.write(" and ${_getFirstName(room.participants.last.name)}");

    return buffer.toString();
  }

  List<game.User> _getUsersWithProfilePictures(ChatRoom room) {
    final users = List<game.User>.from(room.participants
        .map((e) => game.User()
          ..imgUrl = e.imgUrl
          ..name = e.name
          ..userId = e.userId)
        .where((element) => element.userId != room.admin));

    return users.take(2).toList();
  }

  String _getSubtitle(ChatRoom room) {
    final lastMessage = room.messages.last;

    final firstName = _getFirstName(room.participants.firstWhere((e) => e.userId == lastMessage.author).name);
    return "$firstName: ${lastMessage.content}";
  }

  String _getFirstName(String name) {
    return name.split(" ").first;
  }
}
