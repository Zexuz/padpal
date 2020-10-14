import 'package:flutter/material.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:social_repository/social_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_search_view.dart';
import 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  static Route route(BuildContext context, Profile profile) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: context.bloc<MeCubit>(),
        child: ProfilePage(profile),
      ),
    );
  }

  const ProfilePage(this.profile);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);

    return BlocBuilder<MeCubit, MeState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading)
          return CircularProgressIndicator(
            backgroundColor: Colors.blue,
          );

        return Scaffold(
          appBar: state.me.userId == profile.userId
              ? CustomAppBar(title: state.me.name, actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      nav.push(
                        PageRouteBuilder(
                          pageBuilder: (_, animation, secondaryAnimation) => BlocProvider.value(
                            value: context.bloc<MeCubit>(),
                            child: ProfileSearchView(),
                          ),
                        ),
                      );
                    },
                  )
                ])
              : CustomAppBar(title: profile.name),
          backgroundColor: Colors.white,
          body: ProfileView(
            profile: profile,
          ),
        );
      },
    );
  }
}
