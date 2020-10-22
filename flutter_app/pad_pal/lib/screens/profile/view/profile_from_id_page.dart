import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_repository/social_repository.dart';

import 'profile_view.dart';

class ProfileFromId extends StatefulWidget {
  const ProfileFromId(this.profileId);

  final int profileId;

  @override
  _ProfileFromIdState createState() => _ProfileFromIdState();
}

class _ProfileFromIdState extends State<ProfileFromId> {
  Profile profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(),
      body: ProfileView(
        profile: profile,
      ),
    );
  }

  Future<void> _getProfile() async {
    setState(() {
      this.isLoading = true;
    });

    final socialRepo = RepositoryProvider.of<SocialRepository>(context);
    final profile = await socialRepo.getProfile(widget.profileId);
    setState(() {
      this.profile = profile;
      this.isLoading = false;
    });
  }
}
