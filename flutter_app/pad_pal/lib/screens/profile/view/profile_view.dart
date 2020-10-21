import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/theme.dart';
import 'package:social_repository/social_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({@required this.profile});

  final Profile profile;

  Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: displayWidth(context) * 0.08),
            child: Avatar(
              radius: displayWidth(context) * 0.15,
              borderWidth: displayWidth(context) * 0.015,
              url: this.profile.imageUrl,
              color: Colors.white,
              onTap: () async {
                final imageSource = await showModalBottomSheet<ImageSource>(
                    context: context,
                    builder: (_) => Container(
                          height: 200,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25),
                                child: Center(child: Text("Where to import a image from?")),
                              ),
                              Divider(
                                height: 0,
                                thickness: 1,
                              ),
                              Expanded(
                                child: ListView(
                                  children: [
                                    ListTile(
                                      title: Text("Camera"),
                                      onTap: () {
                                        Navigator.pop(context, ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Gallery"),
                                      onTap: () {
                                        Navigator.pop(context, ImageSource.gallery);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));

                if (imageSource == null) {
                  return;
                }

                final image = await ImagePicker().getImage(source: imageSource);

                final croppedFile = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    cropStyle: CropStyle.circle,
                    maxHeight: 300,
                    maxWidth: 300,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                    androidUiSettings: AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      toolbarColor: Colors.deepOrange,
                      toolbarWidgetColor: Colors.white,
                      lockAspectRatio: false,
                    ),
                    iosUiSettings: IOSUiSettings(
                      minimumAspectRatio: 1.0,
                    ));

                context.bloc<MeCubit>().updateProfilePicture(await croppedFile.readAsBytes());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: displayHeight(context) * 0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: AppTheme.lightGrayBackground,
                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                child: Text(this.profile.rank,
                    style: theme.textTheme.subtitle2
                        .copyWith(color: AppTheme.lightGrayText, fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: displayWidth(context) * 0.03),
            child: Text(
              this.profile.name,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: displayWidth(context) * 0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: AppTheme.lightGrayText, size: 12),
                Text(this.profile.location,
                    style: theme.textTheme.subtitle2.copyWith(color: AppTheme.lightGrayText, fontSize: 12))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: displayWidth(context) * 0.04,
                left: displayWidth(context) * 0.08,
                right: displayWidth(context) * 0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatsCountWithLabel(count: this.profile.wins, label: "Wins"),
                _StatsCountWithLabel(count: this.profile.losses, label: "Losses"),
                _StatsCountWithLabel(count: this.profile.friends.length, label: "Friends"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: displayWidth(context) * 0.04,
                left: displayWidth(context) * 0.08,
                right: displayWidth(context) * 0.08),
            child: BlocBuilder<MeCubit, MeState>(
              buildWhen: (previous, current) => previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading)
                  return CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  );

                if (state.me.userId == profile.userId) return Container();

                _FriendStatus friendStatus = _FriendStatus.notFriends;

                if (profile.friendsRequests.contains(state.me.userId)) friendStatus = _FriendStatus.pending;
                if (profile.friends.contains(state.me.userId)) friendStatus = _FriendStatus.friends;

                return _BuildButtons(friendStatus: friendStatus, userId: profile.userId);
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum _FriendStatus { notFriends, pending, friends }

class _BuildButtons extends StatelessWidget {
  _BuildButtons({
    @required this.friendStatus,
    @required this.userId,
  });

  final _FriendStatus friendStatus;
  final int userId;

  @override
  Widget build(BuildContext context) {
    final row = Row(children: []);
    switch (friendStatus) {
      case _FriendStatus.notFriends:
        row.children.add(
          Expanded(
            child: Button.primary(
              child: const Text('Add friend'),
              large: false,
              onPressed: () async {
                try {
                  await context.repository<SocialRepository>().sendFriendRequest(userId);
                  final snackBar = SnackBar(content: Text('Friend request sent'));
                  Scaffold.of(context).showSnackBar(snackBar);
                } catch (e) {
                  final snackBar = SnackBar(content: Text('Failed to send friend request'));
                  Scaffold.of(context).showSnackBar(snackBar);
                  print(e);
                }
              },
            ),
          ),
        );
        break;
      case _FriendStatus.pending:
        row.children.add(Expanded(
          child: Button.light(
            onPressed: null,
            child: Text("Pending friend request"),
            large: false,
          ),
        ));
        break;
      case _FriendStatus.friends:
        row.children.add(Expanded(
          child: Button.light(
            onPressed: () {},
            child: Text("Friends"),
            large: false,
          ),
        ));
        row.children.add(const SizedBox(
          width: 8,
        ));
        row.children.add(Expanded(
          child: Button.primary(
            child: const Text('Chat'),
            large: false,
            onPressed: () {},
          ),
        ));
        break;
    }
    return row;
  }
}

class _StatsCountWithLabel extends StatelessWidget {
  const _StatsCountWithLabel({
    @required this.count,
    @required this.label,
  });

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.23;
    return Container(
      width: width,
      child: Column(
        children: [
          Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          Text(label,
              style: TextStyle(
                color: AppTheme.lightGrayText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
