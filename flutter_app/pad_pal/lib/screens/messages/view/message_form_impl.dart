import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/screens/profile/view/profile_search_view.dart';
import 'package:pad_pal/services/message_list_tile_data_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_repository/social_repository.dart';

import 'message_details_page.dart';
import 'message_form.dart';
import 'message_init_room_page.dart';

class MessageFormReal extends StatefulWidget {
  @override
  _MessageFormRealState createState() => _MessageFormRealState();
}

class _MessageFormRealState extends State<MessageFormReal> {
  var _refreshController = RefreshController(initialRefresh: false);

  List<MessageListTileData> items = <MessageListTileData>[];

  Future<void> _onRefresh(BuildContext context) async {
    final socialRepo = RepositoryProvider.of<SocialRepository>(context);
    final service = GetIt.I.get<MessageListTileDataService>();

    final rooms = await socialRepo.getMyChatRooms();

    final items = <MessageListTileData>[];
    for (var i = 0; i < rooms.length; i++) {
      items.add(service.Build(rooms[i]));
    }
    setState(() {
      this.items = items;
    });

    // final filter = context.bloc<EventFilterCubit>().state;
    // if (filter == null) {
    //   _refreshController.refreshFailed();
    //   return;
    // }
    // await context.bloc<EventCubit>().findGames(filter);
    _refreshController.refreshCompleted();
  }

  // Future<void> _createNewRoom() async {
  //   final socialRepo = RepositoryProvider.of<SocialRepository>(context);
  //
  //   await socialRepo.createRoom(List.from([5]));
  // }

  void _onMessageTap(MessageListTileData data) {
    Navigator.push(
      context,
      MessageDetailsPage.route(data.title, data.roomId),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileSearchView()),
    );

    if (result == null) return;

    final socialRepo = RepositoryProvider.of<SocialRepository>(context);
    final profile = await socialRepo.getProfile(result);


    final roomId = await Navigator.push(
      context,
      MessageInitRoomPage.route(List.from([profile])),
    );

    if(roomId == null) return;

    Navigator.push(
      context,
      MessageDetailsPage.route(profile.name, roomId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: GestureDetector(
              onTap: () => _navigateAndDisplaySelection(context),
              child: AbsorbPointer(
                child: CustomTextInput(
                  onChanged: (value) => print(value),
                  readOnly: true,
                ),
              ),
            ),
          ),
          // Button.primary(child: Text("Create new chat room"), onPressed: () => _createNewRoom()),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              header: MaterialClassicHeader(),
              controller: _refreshController,
              onRefresh: () async {
                await _onRefresh(context);
              },
              child: ListView.builder(
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: MessageListTile(
                      title: items[i].title,
                      subtitle: items[i].subtitle,
                      unread: items[i].unread,
                      users: items[i].users,
                      onTap: () => _onMessageTap(items[i]),
                    ),
                  );
                },
                itemCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
